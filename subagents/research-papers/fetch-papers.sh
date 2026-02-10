#!/bin/bash
# Fetch papers from arxiv and Semantic Scholar
# Usage: ./fetch-papers.sh [output_dir]

set -e

OUTPUT_DIR="${1:-$HOME/Desktop/discovery/arxiv}"
DATE=$(date +%Y-%m-%d)
TEMP_DIR=$(mktemp -d)

echo "Fetching papers for $DATE..."

# --- ARXIV ---
echo "Querying arxiv..."

# Categories focused on PM-relevant AI research:
# cs.HC (Human-Computer Interaction), cs.CL (Language/LLMs), cs.AI (AI applications)
# Removed cs.LG (too theoretical) - keeping applied focus
ARXIV_QUERY="cat:cs.HC+OR+cat:cs.CL+OR+cat:cs.AI"
ARXIV_URL="https://export.arxiv.org/api/query?search_query=${ARXIV_QUERY}&sortBy=submittedDate&sortOrder=descending&max_results=15"

curl -s "$ARXIV_URL" > "$TEMP_DIR/arxiv_raw.xml"

# Parse arxiv XML to simple format
python3 - "$TEMP_DIR/arxiv_raw.xml" "$TEMP_DIR/arxiv.json" << 'PYEOF'
import xml.etree.ElementTree as ET
import json
import sys

input_file = sys.argv[1]
output_file = sys.argv[2]

ns = {'atom': 'http://www.w3.org/2005/Atom', 'arxiv': 'http://arxiv.org/schemas/atom'}

tree = ET.parse(input_file)
root = tree.getroot()
papers = []

for entry in root.findall('atom:entry', ns):
    title = entry.find('atom:title', ns)
    abstract = entry.find('atom:summary', ns)
    link = entry.find("atom:link[@type='text/html']", ns)
    if link is None:
        link = entry.find("atom:link", ns)

    authors = []
    for author in entry.findall('atom:author', ns):
        name = author.find('atom:name', ns)
        if name is not None:
            authors.append(name.text)

    categories = []
    for cat in entry.findall('atom:category', ns):
        categories.append(cat.get('term', ''))

    papers.append({
        'source': 'arxiv',
        'title': title.text.strip().replace('\n', ' ') if title is not None else '',
        'authors': authors[:5],
        'abstract': abstract.text.strip().replace('\n', ' ')[:1500] if abstract is not None else '',
        'url': link.get('href', '') if link is not None else '',
        'categories': [c for c in categories if c.startswith('cs.')][:3]
    })

with open(output_file, 'w') as f:
    json.dump(papers, f, indent=2)
PYEOF

# --- SEMANTIC SCHOLAR ---
echo "Querying Semantic Scholar..."

# PM-focused query: AI assistants, chatbots, user studies, product applications
SS_URL="https://api.semanticscholar.org/graph/v1/paper/search?query=AI+assistant+OR+conversational+AI+OR+human-AI+interaction+OR+LLM+user+study+OR+AI+product+OR+chatbot+evaluation&year=2025-2026&fields=title,authors,abstract,url,year,citationCount&limit=10"

curl -s "$SS_URL" > "$TEMP_DIR/ss_raw.json"

# Parse Semantic Scholar JSON
python3 - "$TEMP_DIR/ss_raw.json" "$TEMP_DIR/semantic_scholar.json" << 'PYEOF'
import json
import sys

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file) as f:
    data = json.load(f)

papers = []
for paper in data.get('data', []):
    if not paper.get('abstract'):
        continue
    authors = [a.get('name', '') for a in paper.get('authors', [])[:5]]
    papers.append({
        'source': 'semantic_scholar',
        'title': paper.get('title', ''),
        'authors': authors,
        'abstract': paper.get('abstract', '')[:1500],
        'url': paper.get('url', ''),
        'categories': ['AI/ML'],
        'citations': paper.get('citationCount', 0)
    })

with open(output_file, 'w') as f:
    json.dump(papers, f, indent=2)
PYEOF

# --- COMBINE ---
echo "Combining results..."

python3 - "$TEMP_DIR/arxiv.json" "$TEMP_DIR/semantic_scholar.json" "$TEMP_DIR/all_papers.json" << 'PYEOF'
import json
import sys

arxiv_file = sys.argv[1]
ss_file = sys.argv[2]
output_file = sys.argv[3]

arxiv = json.load(open(arxiv_file))
ss = json.load(open(ss_file))

# Simple dedup by title similarity
seen = set()
combined = []

for paper in arxiv + ss:
    key = paper['title'].lower()[:50]
    if key not in seen:
        seen.add(key)
        combined.append(paper)

with open(output_file, 'w') as f:
    json.dump(combined, f, indent=2)
PYEOF

# Output path for Claude to read
mkdir -p "$OUTPUT_DIR"
cp "$TEMP_DIR/all_papers.json" "$OUTPUT_DIR/.papers_raw_$DATE.json"
echo "Raw papers saved to: $OUTPUT_DIR/.papers_raw_$DATE.json"

PAPER_COUNT=$(python3 -c "import json; print(len(json.load(open('$TEMP_DIR/all_papers.json'))))")

# Cleanup
rm -rf "$TEMP_DIR"

echo "Done. Found $PAPER_COUNT papers."
