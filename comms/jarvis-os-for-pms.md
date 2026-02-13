# Jarvis OS: A PM's Personal Operating System

**TL;DR:** Claude Code is a coding assistant. Jarvis is a thinking partner that remembers your context, challenges your assumptions, and never makes things up.

---

## The Problem

You're a PM. You live in documents — PRDs, PRFAQs, strategy decks, stakeholder updates.

You try using AI assistants. Here's what happens:

**Day 1:** "Summarize this PRD." Great output.

**Day 2:** "What did we decide about the migration timeline?"

*"I don't have access to previous conversations..."*

Sound familiar?

**Day 3:** You paste the same 80KB PRD again. Ask a question. The AI confidently states something that isn't in the document.

You check. It made it up.

**Day 4:** You ask for a PRD review. You get generic feedback that could apply to any product. No awareness of your company's strategy, your stakeholders, your constraints.

Every. Single. Time.

---

## What Jarvis OS Is

Jarvis is a layer on top of Claude Code that turns it from a stateless assistant into a **personal PM operating system**.

It solves three problems:

| Problem | How Jarvis Solves It |
|---------|---------------------|
| **Context amnesia** | 3-layer persistent memory (user → project → session) |
| **Confident hallucinations** | Source attribution required — cite or admit ignorance |
| **Generic feedback** | Knows your company, your docs, your writing style |

---

## Key Features

### 1. Persistent Memory 🧠

**The pain:** Every conversation starts from zero. You re-explain your project, paste the same docs, rebuild context.

**The fix:** Jarvis remembers across sessions.

```
┌─────────────────────────────────────────┐
│  SESSION (This Conversation)            │
│  Current task, working decisions        │
└─────────────────────────────────────────┘
                    ↓ persists to
┌─────────────────────────────────────────┐
│  PROJECT (Per-Project Cache)            │
│  Your PRDs, PRFAQs, dependencies        │
└─────────────────────────────────────────┘
                    ↓ informs
┌─────────────────────────────────────────┐
│  USER (Permanent)                       │
│  Your preferences, writing style,       │
│  learnings, company context             │
└─────────────────────────────────────────┘
```

**Before:**
- "Here's the PRD again..." (paste 80KB)
- "Remember, we decided to..." (re-explain context)
- "My company does..." (repeat background)

**After:**
- "What's the status of platform migration?"
- Jarvis already knows. Answers with citation.

---

### 2. Grounded Answers Only 📍

**The pain:** AI confidently states things that aren't true. You waste time fact-checking or worse — you don't check and make decisions on hallucinated data.

**The fix:** Every factual claim requires a source. No source? Jarvis says so.

**Vanilla Claude:**
> "The migration timeline is Q3 2026 with a focus on enterprise customers."

(Did it read that somewhere? Or did it just... sound right?)

**Jarvis:**
> "Q2 2026, with feature parity as the core principle."
>
> *Source: Platform Migration PRD v0.6, Section 2.1*
> *Confidence: High — direct quote*

Or when it doesn't know:

> "I don't have a source for the pricing decision. Want me to search Drive?"

That's it. No confident bullshit.

---

### 3. Validate-Before-Cite 🔄

**The pain:** You cached a doc last week. Someone updated it yesterday. You ask a question. You get stale information.

**The fix:** Before citing any cached document, Jarvis checks if the source changed.

```
About to cite cached PRD
         ↓
Check Drive: has it been modified?
         ↓
Same? → Use cache
         ↓
Changed? → Refresh first → Then cite fresh data
```

**Cost:** ~50ms metadata call. You won't notice.

**Guarantee:** You'll never get outdated information from cache.

---

### 4. Auto-Delegation to Specialists 🤖

**The pain:** You want a PRD review. You get surface-level feedback. No one checks technical feasibility. No one validates user value. No one pressure-tests strategic alignment.

**The fix:** Say "review this PRD" and Jarvis spawns three specialist agents in parallel:

| Agent | Focus |
|-------|-------|
| **Engineer** | Technical feasibility, dependencies, API risks |
| **Executive** | Strategic alignment, stakeholder clarity, business case |
| **User Researcher** | User value, adoption risks, validation evidence |

You get a multi-perspective review without managing three conversations.

---

### 5. Knows Your Voice ✍️

**The pain:** AI-generated content sounds like AI. Generic. Corporate. Not you.

**The fix:** Jarvis knows your writing style.

**Formal mode** (PRDs, stakeholder updates):
- Metadata headers
- Numbered sections
- Tables for comparisons
- "Problem → Solution → Impact" pattern

**Casual mode** (LinkedIn, explanations):
- Short paragraphs
- Rhetorical questions
- "That's the whole game."
- "Worth it? Hell yes."

When you say "draft a LinkedIn post about this feature," it sounds like you wrote it.

---

### 6. Sparring Partner, Not Yes-Machine 🥊

**The pain:** You share an idea. AI says "Great idea!" You ask if it makes sense. "Absolutely!"

You don't need validation. You need someone to find the holes.

**The fix:** Jarvis is explicitly configured to:

- Challenge your assumptions
- Find blind spots you're ignoring
- Steelman alternatives before agreeing
- Point out logical inconsistencies
- Ask uncomfortable questions

**Vanilla Claude:**
> "That's a solid approach! The phased rollout makes sense."

**Jarvis:**
> "I'd push back on the phased rollout. You're assuming enterprise customers will wait for Phase 2 features, but the dependency table shows 3 of their top 5 requests are Phase 3. What's your plan when they ask for acceleration?"

---

## Jarvis vs. Vanilla Claude Code

| Capability | Vanilla Claude Code | Jarvis OS |
|------------|---------------------|-----------|
| **Memory** | Single conversation | 3-layer persistent (user/project/session) |
| **Context loading** | Paste docs every time | Auto-cached, validated fresh on cite |
| **Factual claims** | Confident (sometimes wrong) | Source-cited or "I don't know" |
| **Document reviews** | Generic feedback | Multi-agent specialist review |
| **Writing style** | Generic AI voice | Matches your voice (formal/casual) |
| **Interaction mode** | Helpful assistant | Sparring partner |
| **Stale data** | Possible | Impossible (validate-before-cite) |
| **MCP integrations** | Available | Pre-configured (Notion, Drive, Gmail) |
| **Token efficiency** | Full docs in context | Tiered cache (~90% reduction) |

---

## How It Works

**Setup:** One-time configuration of your preferences, writing style, and company context.

**Per-project:** Drop a `.jarvis.md` file listing critical documents. Jarvis auto-caches them.

**Daily use:**
```
/jarvis
```

That's it. Jarvis loads your memory, detects your project, validates your cache, and is ready.

Ask questions. Get grounded answers. Request reviews. Get multi-perspective feedback.

---

## The ROI

### Token Efficiency

| Scenario | Vanilla | Jarvis |
|----------|---------|--------|
| 3 docs (160KB) | ~40,000 tokens | ~3,750 tokens |
| 10 questions | ~185,000 tokens | ~5,000 tokens |
| **Savings** | — | **~97%** |

### Time Savings

- No re-pasting documents
- No re-explaining context
- No fact-checking AI outputs (already cited)
- No managing multiple review conversations

### Quality Improvements

- Multi-perspective reviews catch more issues
- Grounded answers reduce bad decisions
- Sparring partner mode surfaces blind spots
- Fresh data guaranteed (no stale cache citations)

---

## Who This Is For

✅ PMs who live in documents (PRDs, PRFAQs, strategy docs)

✅ PMs who use AI but don't trust it fully

✅ PMs who want a thinking partner, not a yes-machine

✅ PMs who are tired of re-pasting context every conversation

✅ PMs who need multi-perspective feedback without managing multiple tools

---

## What's Next

**Try it:**
```
/jarvis
```

**Configure your project:**
Create `.jarvis.md` with your critical documents.

**Let it learn:**
Use it. Correct it when wrong. It remembers.

---

*Jarvis OS v2.1 — Your personal PM operating system.*

*"If you want validation, I'm the wrong system. If you want your thinking stress-tested, we'll get along splendidly."*
