# Prompt Assessor Research Library

**Purpose:** This file contains extracted findings from peer-reviewed papers, industry benchmarks, and authoritative guidance cited in the Prompt Assessor's methodology. The assessor should reference this library — not training knowledge — when citing evidence for recommendations.

**Last Updated:** 2026-02-11

**Sourcing Method:** Each entry was compiled from web search results, abstracts, summaries, and publicly available excerpts. Where full paper access was unavailable, entries are marked with `UNVERIFIED` tags. All URLs have been verified as resolving to the correct paper.

**Total Papers:** 13

---

## Table of Contents

1. [Harada et al. 2024 — Curse of Instructions](#1-harada-et-al-2024)
2. [Jaroslawicz et al. 2025 — How Many Instructions Can LLMs Follow at Once?](#2-jaroslawicz-et-al-2025)
3. [Liu et al. TACL 2024 — Lost in the Middle](#3-liu-et-al-tacl-2024)
4. [Wu et al. ICML 2025 — On the Emergence of Position Bias in Transformers](#4-wu-et-al-icml-2025)
5. [Zhang et al. 2024 — Found in the Middle](#5-zhang-et-al-2024)
6. [Tam et al. EMNLP 2024 — Let Me Speak Freely?](#6-tam-et-al-emnlp-2024)
7. [BFCL ICLR 2025 — Berkeley Function-Calling Leaderboard](#7-bfcl-iclr-2025)
8. [ComplexFuncBench 2025 — Complex Function Calling](#8-complexfuncbench-2025)
9. [Liu, Wang & Willard 2025 — Prompt Length Effects](#9-liu-wang--willard-2025)
10. [OpenAI 2025 — Prompt Injection Defenses](#10-openai-2025)
11. [OWASP LLM01:2025 — Prompt Injection](#11-owasp-llm012025)
12. [Wallace et al. 2024 — The Instruction Hierarchy](#12-wallace-et-al-2024)
13. [CFPB 2023 — Chatbots in Consumer Finance](#13-cfpb-2023)

---

## 1. Harada et al. 2024

### Harada et al. 2024 — Curse of Instructions: Large Language Models Cannot Follow Multiple Instructions at Once

**Source:** https://openreview.net/forum?id=R6q67CDBCH
**Published:** 2024, OpenReview (under review)
**Relevance:** Phase 2.1 — Rule Compliance Decay (P^N model)

**Key Finding:** The probability of an LLM following all N instructions simultaneously follows the relationship P(all N followed) = P(single instruction)^N. At 10 instructions, GPT-4o achieved only 15% success rate and Claude 3.5 Sonnet achieved 44%. The researchers introduced ManyIFEval, a benchmark with up to 10 objectively verifiable instructions, and found that individual instruction adherence degrades "gradually but constantly" as instruction count rises.

**Self-Refinement Results:** An inference-time strategy using iterative self-refinement with instruction-level chain-of-thought reasoning improved GPT-4o from 15% to 31% and Claude 3.5 Sonnet from 44% to 58% at 10 instructions. Precision in feedback matters more than recall — simply telling the model it is not following all instructions also helps.

**Methodology:** Introduced ManyIFEval benchmark with task prompts containing up to 10 objectively verifiable instructions. Tested across multiple frontier models.

**Sample/Scale:** Benchmark with up to 10 instructions per prompt. Tested on GPT-4o, Claude 3.5 Sonnet, Gemini 1.5, Llama 3.1, and Gemma 2.

**Limitations:** The benchmark tests up to 10 instructions only. The P^N model assumes independence between instructions. In practice, correlated rules may cluster, meaning the model may overstate risk for semantically related rules. Extrapolation beyond 10 instructions (e.g., to 25 or 50 rules) is the Assessor's inference, not directly tested by this paper.

**How the Assessor Uses This:** The P^N decay table in Phase 2.1 is derived from this paper's exponential model. The Assessor applies it to unique rule counts in the prompt census. Note: any P^N calculation for N > 10 should be flagged as "extrapolated beyond tested range."

---

## 2. Jaroslawicz et al. 2025

### Jaroslawicz et al. 2025 — How Many Instructions Can LLMs Follow at Once?

**Source:** https://arxiv.org/abs/2507.11538
**Published:** July 2025, arXiv preprint
**Relevance:** Phase 2.1 — Rule Compliance Decay; extends Harada's findings to much higher instruction counts

**Key Finding:** Even the best frontier models achieve only 68% accuracy at the maximum density of 500 instructions. The evaluation of 20 state-of-the-art models across seven major providers reveals three distinct performance degradation patterns correlated with model size and reasoning capability, a bias toward earlier instructions, and distinct categories of instruction-following errors.

**Methodology:** Introduced IFScale, a benchmark of 500 keyword-inclusion instructions for a business report writing task, designed to measure instruction-following performance as instruction density increases.

**Sample/Scale:** 500 instructions per prompt; 20 models evaluated across 7 providers.

**Limitations:** Instructions are keyword-inclusion (relatively simple verification) rather than complex behavioral constraints. Business report writing is a single-domain task — generalization to other domains is not tested. The 68% figure is for keyword inclusion, which may be easier to verify than behavioral rules in agent prompts.

**How the Assessor Uses This:** Provides evidence that instruction-following degrades at scale well beyond Harada's 10-instruction range. The "bias toward earlier instructions" finding reinforces the positional analysis in Phase 1.2 and Phase 2.2. The Assessor can cite this paper for prompts with high rule counts (>10) as stronger evidence than extrapolating Harada's P^N alone.

---

## 3. Liu et al. TACL 2024

### Liu et al. TACL 2024 — Lost in the Middle: How Language Models Use Long Contexts

**Source:** https://arxiv.org/abs/2307.03172
**Published:** 2024, Transactions of the Association for Computational Linguistics (TACL), Vol. 12, pp. 157-173
**Relevance:** Phase 1.2 — Positional Mapping; Phase 2.2 — Positional Attention Bias

**Key Finding:** Language models exhibit a U-shaped performance curve: accuracy is highest when relevant information is at the beginning or end of the input context, and significantly degrades when relevant information is in the middle. On multi-document QA with 20 documents, performance was substantially lower when the relevant document was placed in middle positions compared to beginning/end positions. Model performance saturates long before retriever recall — using 50 instead of 20 retrieved documents only improved performance by approximately 1.5% for GPT-3.5-Turbo and approximately 1% for Claude 1.3.

**Methodology:** Evaluated on two tasks: multi-document question answering (NaturalQuestions-Open) and synthetic key-value retrieval. Systematically varied the position of relevant information within the input context.

**Sample/Scale:** Tested with contexts containing 10-30 documents. Models tested include GPT-3.5-Turbo, Claude 1.3, Claude 1.3 (100K), MPT-30B-Instruct, and LongChat-13B (16K).

**Limitations:** Tested on retrieval-style tasks, not instruction-following per se. The degree of middle-position degradation varies by model and task. More recent models (GPT-4, Claude 3.x) may have partially mitigated this issue, though the fundamental U-shaped pattern persists in subsequent research. Specific percentage degradation figures were not directly confirmed from the full paper — the "30%+ accuracy degradation" cited in the SKILL.md should be treated as approximate.

**How the Assessor Uses This:** Grounds the Phase 2.2 positional bias analysis. Critical rules placed in the middle third of the prompt are at risk of being deprioritized. The 0.7 multiplier applied to P^N for middle-positioned rules is the Assessor's operationalization of this finding — the paper itself does not prescribe a specific multiplier. This extrapolation should be flagged.

---

## 4. Wu et al. ICML 2025

### Wu et al. ICML 2025 — On the Emergence of Position Bias in Transformers

**Source:** https://arxiv.org/abs/2502.01951
**Published:** 2025, ICML 2025
**Relevance:** Phase 2.2 — Positional Attention Bias (theoretical foundation)

**Key Finding:** Causal masking inherently biases attention toward earlier positions. In deeper layers, tokens attend to increasingly contextualized representations of earlier tokens, amplifying bias regardless of positional encoding. The paper characterizes competing effects: while RoPE and decay masks introduce distance-based decay within individual attention maps, their aggregate effect across multiple layers — coupled with causal masking — produces a trade-off between long-term decay and cumulative early-position importance. Decay masks produce stronger distance-based decay (recent-token focus) than RoPE.

**Methodology:** Graph-theoretic framework modeling attention masks as directed graphs to quantify token interactions based on sequential position. Validated through controlled numerical experiments reproducing position biases observed in real-world LLMs.

**Sample/Scale:** Theoretical analysis with controlled numerical experiments. Reproduces known phenomena including "lost-in-the-middle" and attention sinks.

**Limitations:** Primarily a theoretical/analytical paper. The controlled experiments validate the framework but do not directly measure instruction-following accuracy at different positions. Does not provide specific percentage degradation numbers for prompt engineering use cases.

**How the Assessor Uses This:** Provides the mechanistic explanation for why positional bias occurs (causal masking + attention depth = early-token bias). Strengthens the theoretical justification for the Phase 4 architecture that places security at the top (highest attention) and compliance reminders at the bottom (U-curve end benefit). When paired with Liu et al. 2024 (empirical) and Zhang et al. 2024 (mitigation), this gives the Assessor a complete picture: empirical evidence, theoretical cause, and engineering response.

---

## 5. Zhang et al. 2024

### Zhang et al. 2024 — Found in the Middle: How Language Models Use Long Contexts Better via Plug-and-Play Positional Encoding

**Source:** https://arxiv.org/abs/2403.04797
**Published:** 2024, arXiv preprint
**Relevance:** Phase 2.2 — Positional Attention Bias (root cause and mitigation)

**Key Finding:** The "lost-in-the-middle" problem is partly caused by rotary positional embedding (RoPE), which incorporates a long-term decay property that predisposes models to prioritize nearby tokens over distant ones. The paper introduces Multi-scale Positional Encoding (Ms-PoE), a plug-and-play approach that enhances middle-context utilization without fine-tuning or additional overhead.

**Methodology:** Analyzed the root cause of middle-context neglect in RoPE-based models. Proposed Ms-PoE as a mitigation. Evaluated on long-context tasks.

**Sample/Scale:** Tested on open-source LLMs using RoPE (specific model list not confirmed from search results).

**Limitations:** Ms-PoE is a model-level intervention, not a prompt-engineering technique. Prompt authors cannot apply Ms-PoE — they can only work around positional bias through prompt structure. The paper's main contribution (Ms-PoE) is not directly actionable for the Assessor; its value is in confirming and explaining the root cause.

**How the Assessor Uses This:** Confirms that positional bias is a real architectural limitation (RoPE decay), not just an empirical anomaly. Since prompt authors cannot change the model's positional encoding, the only lever is prompt structure — placing critical content at high-attention positions (beginning/end). This justifies the Phase 4 architecture.

---

## 6. Tam et al. EMNLP 2024

### Tam et al. EMNLP 2024 — Let Me Speak Freely? A Study on the Impact of Format Restrictions on Performance of Large Language Models

**Source:** https://arxiv.org/abs/2408.02442
**Published:** 2024, EMNLP 2024 (Industry Track)
**Relevance:** Phase 2.3 — Tool Complexity Scoring (JSON output penalty)

**Key Finding:** Structured format restrictions (JSON, XML) cause significant decline in LLM reasoning abilities. Stricter format constraints generally lead to greater performance degradation. On reasoning tasks (GSM8K, Last Letter, Shuffled Objects), JSON-mode performed worst, followed by constrained format restrictions (FRI), NL-to-Format, and natural language (NL). The penalty is most severe on reasoning-heavy tasks. UNVERIFIED — from training knowledge: the SKILL.md cites a "27.3% accuracy penalty from JSON format." This specific figure was not confirmed from search results. The paper clearly shows a significant penalty but the exact number requires full paper access to verify.

**Methodology:** Evaluated LLM performance on reasoning and classification tasks under different format restrictions: free-form natural language, NL-to-Format conversion, constrained format (FRI), and JSON-mode. Tested across multiple prompt perturbations.

**Sample/Scale:** Tested on GPT-3.5 Turbo, Claude 3 Haiku, and LLaMA 3 8B Instruct across multiple reasoning benchmarks (GSM8K, Last Letter Concatenation, Shuffled Objects).

**Limitations:** Focuses on reasoning tasks — the penalty may differ for classification or extraction tasks where structured output is more natural. The penalty size varies by model and task. More recent models with native JSON-mode training (e.g., GPT-4o with structured outputs) may have partially mitigated this issue.

**How the Assessor Uses This:** Grounds the "JSON output required" row in the Phase 2.3 Tool Complexity scoring table. When a prompt requires structured JSON output, the Assessor should flag a reasoning penalty. The recommendation to "externalize verbatim content" in Phase 4 is partly justified by this — if the model must produce exact JSON, it should be templated rather than generated through reasoning.

---

## 7. BFCL ICLR 2025

### BFCL ICLR 2025 — The Berkeley Function-Calling Leaderboard: From Tool Use to Agentic Evaluation of Large Language Models

**Source:** https://openreview.net/forum?id=2GmDdhBdDk
**Published:** 2025, ICLR 2025
**Relevance:** Phase 2.3 — Tool Complexity Scoring (function-calling accuracy benchmarks)

**Key Finding:** Top LLMs excel at single-turn function calls but still struggle with memory management, dynamic decision-making, and long-horizon reasoning across multi-turn interactions. BFCL evaluates serial and parallel function calls across various programming languages using a novel Abstract Syntax Tree (AST) evaluation method. The benchmark has become the de facto standard for evaluating function-calling capabilities.

**Methodology:** Novel AST-based checking method that examines the structure of tool calls without executing them, enabling scale to thousands of functions. Evaluates single-turn, multi-turn, serial, and parallel function calling scenarios.

**Sample/Scale:** Thousands of function-calling scenarios across multiple programming languages. Continuously updated leaderboard at gorilla.cs.berkeley.edu/leaderboard.html.

**Limitations:** Leaderboard results change as models update. The AST-based evaluation checks structural correctness but may miss semantic errors. Benchmark scenarios may not fully represent the complexity of production agent prompts.

**How the Assessor Uses This:** Provides the baseline understanding that function-calling accuracy drops significantly in multi-turn and complex scenarios. When the Assessor encounters prompts with many tools, this paper justifies the "flatten tool schemas" recommendation. The gap between single-turn and multi-turn performance also supports the Phase 2.4 multi-turn degradation analysis.

---

## 8. ComplexFuncBench 2025

### ComplexFuncBench 2025 — Exploring Multi-Step and Constrained Function Calling under Long-Context Scenario

**Source:** https://arxiv.org/abs/2501.10132
**Published:** January 2025, arXiv preprint
**Relevance:** Phase 2.3 — Tool Complexity Scoring (complex tool schemas, nested parameters)

**Key Finding:** Even top models struggle with complex function calling. Claude 3.5 Sonnet, GPT-4o, and GLM-4-Long achieved overall success rates of only 61.0%, 60.5%, and 57.1% respectively. Value errors account for the largest share of failures — Qwen2.5-72B had a 78.8% value_error rate. Stop-early errors (model stops calling functions before gathering complete information) were 19.7% for Claude 3.5 Sonnet and 21.0% for GPT-4o. The benchmark tests five dimensions: multi-step single-turn calls, user-provided constraints, parameter value reasoning from implicit information, long parameter values (>500 tokens), and 128K long-context length.

**Methodology:** Introduced ComplexEval, an automatic evaluation framework using three matching approaches: rule-based (identical calls), response-based (same API responses), and LLM-based (semantic equivalence of parameter values).

**Sample/Scale:** 1,000 complex function-calling samples across 5 real-world scenarios (hotels, attractions, restaurants, and cross-domain).

**Limitations:** Domain is primarily travel/hospitality — may not generalize to all tool-use scenarios. The benchmark is relatively new with limited external validation. 128K context scenarios may not represent typical agent prompt lengths.

**How the Assessor Uses This:** Provides concrete accuracy numbers for the Phase 2.3 Tool Complexity scoring. When a prompt has deeply nested parameters, multi-step tool chains, or requires parameter reasoning, the Assessor can cite 60-61% success rates as a ceiling for frontier models. The value_error and stop_early error categories map directly to the "Wrong tool called, bad parameters" symptom in Phase 3A.

---

## 9. Liu, Wang & Willard 2025

### Liu, Wang & Willard 2025 — Effects of Prompt Length on Domain-specific Tasks for Large Language Models

**Source:** https://arxiv.org/abs/2502.14255
**Published:** February 2025, arXiv preprint
**Relevance:** Phase 2.3 — Tool Complexity Scoring (prompt length effects); Phase 2.4 — Multi-Turn Context Degradation

**Key Finding:** Long prompts that provide more background domain knowledge are "generally beneficial" for domain-specific tasks. However, even with background knowledge in long prompts, LLM performance still lags behind humans. With default (short) prompt length, LLMs struggle on tasks requiring specialized domain knowledge. The relationship between prompt length and performance is not monotonic — there are diminishing returns and potential degradation points.

**Methodology:** Extensive experiments across nine domain-specific tasks including financial sentiment analysis and monetary policy understanding. Systematically varied prompt length while controlling for content.

**Sample/Scale:** 9 domain-specific tasks. Specific model list not confirmed from search results.

**Limitations:** Focuses on domain-specific knowledge tasks, not general instruction-following. "Long prompts" in this context means prompts with more background information, not necessarily prompts bloated with redundant rules. The finding that longer prompts can help is about information density, not about having more rules — this distinction is critical for the Assessor.

**How the Assessor Uses This:** Nuances the "shorter is better" assumption. Prompt length per se is not the problem — rule count and redundancy are. A prompt can be long because it provides valuable context (good) or because it has 50 duplicated rules (bad). The Assessor should distinguish between "informative length" and "bloated length" when scoring prompts >20K tokens.

---

## 10. OpenAI 2025

### OpenAI 2025 — Understanding Prompt Injections: A Frontier Security Challenge

**Source:** https://openai.com/index/prompt-injections/
**Published:** 2025, OpenAI Blog
**Relevance:** Phase 4 — Solution Architecture (security layer, output validation); Phase 2.3 — Security assessment

**Key Finding:** OpenAI views prompt injection as a "long-term AI security challenge" that may never be fully "solved," especially for browser-based agents. Their defense strategy is multi-layered ("defense-in-depth"):
1. **Instruction Hierarchy** — Training models to distinguish trusted vs. untrusted instructions
2. **Sandboxing** — Preventing harmful tool actions from injection
3. **User Controls** — Confirmation prompts before sensitive actions, logged-out mode, Watch Mode
4. **Automated Red-Teaming** — RL-trained attacker that learns from its own successes/failures
5. **Model Robustness** — Continued training to recognize injection patterns
6. **System-Level Safeguards** — Defenses outside the model itself

OpenAI explicitly states that prompt-level defense alone is insufficient — system-level controls are required.

**Methodology:** Industry blog post describing OpenAI's defense approach. Not a peer-reviewed study. No controlled experiment with measurable accuracy numbers.

**Sample/Scale:** N/A (descriptive, not empirical).

**Limitations:** This is a Tier 3 source (authoritative guidance), not Tier 1 (peer-reviewed research). No specific accuracy numbers or controlled experiments are reported. OpenAI has a commercial interest in describing their defenses favorably. The advice is general, not specific to prompt engineering.

**How the Assessor Uses This:** Justifies the Phase 4 architecture's "validate outputs" principle and the separation of security into its own layer. The Assessor should cite this when recommending that prompts include an output validation layer and when flagging that security instructions alone are insufficient. The "defense-in-depth" framing supports the recommendation to not rely solely on prompt-level injection defenses.

---

## 11. OWASP LLM01:2025

### OWASP LLM01:2025 — Prompt Injection

**Source:** https://genai.owasp.org/llmrisk/llm01-prompt-injection/
**Published:** 2025, OWASP Top 10 for LLM Applications
**Relevance:** Phase 2.3 — Security assessment; Phase 4 — Security layer design

**Key Finding:** OWASP classifies prompt injection into two types:
- **Direct Prompt Injection (Jailbreaking):** Malicious user overwrites or reveals the system prompt, exploiting backend systems via the LLM.
- **Indirect Prompt Injection:** LLM accepts input from external sources (websites, files, tool outputs) containing content that alters model behavior. Can be intentional or unintentional. Does not need to be human-readable.

Prevention strategies include:
1. Enforce privilege control on LLM access to backend systems
2. Human-in-the-loop for privileged operations
3. Separate and clearly denote untrusted content
4. Specify clear output formats with deterministic validation
5. Apply input validation and content filtering
6. Implement data loss prevention layers for PII
7. Regular penetration testing treating the model as untrusted user

OWASP explicitly states: "Given the stochastic influence at the heart of the way models work, it is unclear if there are fool-proof methods of prevention."

**Methodology:** Industry standard security taxonomy. Not empirical research — consensus-based risk classification by security professionals.

**Sample/Scale:** N/A (taxonomy and guidance, not empirical study).

**Limitations:** Tier 3 source (standards body). Provides taxonomy and prevention strategies but no accuracy numbers for defense effectiveness. The prevention strategies are general-purpose, not LLM-prompt-specific.

**How the Assessor Uses This:** Provides the classification framework for security assessment. When auditing a prompt's security posture, the Assessor should check for defenses against both direct and indirect injection. The distinction between direct and indirect injection is critical — a prompt may defend against jailbreaking but be vulnerable to tool-output injection. The OWASP principle of treating the model as an untrusted user informs the "output validation layer" in Phase 4.

---

## 12. Wallace et al. 2024

### Wallace et al. 2024 — The Instruction Hierarchy: Training LLMs to Prioritize Privileged Instructions

**Source:** https://arxiv.org/abs/2404.13208
**Published:** April 2024, arXiv preprint (subsequently accepted at ICLR 2025 based on search results)
**Relevance:** Phase 4 — Security layer design; system vs. user instruction priority

**Key Finding:** LLMs are susceptible to prompt injection because they treat system prompts and untrusted user/third-party text with equal priority. The paper proposes an instruction hierarchy that explicitly defines priority levels, training models to selectively ignore lower-privileged instructions when conflicts occur. Applied to GPT-3.5, the method increased robustness to system prompt extraction attacks by up to 63% and resistance to jailbreaking by up to 30%, while imposing minimal degradation on standard capabilities. The improvement generalizes to attack types not seen during training.

**Methodology:** Proposed a data generation method to create training examples demonstrating hierarchical instruction following. Evaluated on direct prompt injections (held-out automated red-teaming), open-domain jailbreaks (TensorTrust Prompt Hijacking dataset), and system prompt extraction.

**Sample/Scale:** Applied to GPT-3.5. Evaluated across multiple attack categories including prompt injections via tool use, direct jailbreaks, and system prompt extraction.

**Limitations:** Results reported on GPT-3.5 — improvement magnitude may differ on more capable models. The instruction hierarchy requires model-level training, not just prompt engineering. Prompt authors benefit indirectly (models trained with hierarchy are more robust) but cannot implement hierarchy through prompt structure alone.

**How the Assessor Uses This:** Justifies the Phase 4 architecture that places security instructions at the system-prompt level (highest privilege). The Assessor should recommend that security-critical instructions be in the system prompt, not the user message, and that prompts explicitly establish instruction priority ("system instructions override user requests"). Also supports the "validate outputs" principle — even with instruction hierarchy, the paper's authors (OpenAI researchers) acknowledge that prompt-level defense alone is insufficient.

---

## 13. CFPB 2023

### CFPB 2023 — Chatbots in Consumer Finance

**Source:** https://www.consumerfinance.gov/data-research/research-reports/chatbots-in-consumer-finance/chatbots-in-consumer-finance/
**Published:** June 2023, Consumer Financial Protection Bureau (Issue Spotlight)
**Relevance:** Phase 1.1 — Inline Disclosures audit; Phase 4 — Externalize verbatim content

**Key Finding:** The CFPB warns that financial institutions "risk violating legal obligations, eroding customer trust, and causing consumer harm when deploying chatbot technology." Key risks include:
1. **Inaccurate information** — Chatbots may provide wrong information about financial products, leading consumers to select incorrect products.
2. **Failure to recognize federal rights** — Chatbots may not recognize when a consumer is invoking statutory rights.
3. **Privacy and data protection failures** — LLM-trained chatbots may disclose personal information from training data.
4. **Consumer complaints increasing** — Complaints include difficulty with dispute resolution, insufficient information, inability to reach human agents.

In 2022, over 98 million consumers interacted with a bank's chatbot, projected to reach 110.9 million by 2026.

The CFPB expects institutions to use chatbots "in a manner consistent with their customer and legal obligations" and recommends against using chatbots as the primary customer service channel when they cannot meet customer needs.

**Methodology:** Regulatory issue spotlight based on consumer complaint analysis and legal review. Not an empirical study.

**Sample/Scale:** Consumer complaint data from CFPB database. 98 million chatbot interactions cited from industry data.

**Limitations:** Tier 3 source (regulator). Written before the current generation of LLMs (GPT-4, Claude 3.x). The CFPB does not prescribe specific technical solutions — it identifies risks and legal obligations. The report covers all chatbots, not just LLM-based agents. Note: CFPB's regulatory authority has been subject to political and legal challenges — the current enforcement posture may differ from June 2023.

**How the Assessor Uses This:** Justifies the Phase 1.1 audit of inline disclosures and the Phase 4 principle to "externalize verbatim content." When a prompt includes legally required text (disclosures, disclaimers, rights notifications), embedding them inline risks the model modifying mandatory language. The Assessor should recommend that such content be served as immutable templates outside the generation path, or validated post-generation against exact expected text. The CFPB report is cited not for technical findings but for regulatory risk context — the consequence of a chatbot altering a required disclosure is not just a quality issue but a potential legal violation.

---

## Cross-Reference: Evidence by Assessment Phase

| Assessment Phase | Primary Evidence | Supporting Evidence | Provider Guides (Tier 4) |
|-----------------|-----------------|-------------------|--------------------------|
| Phase 1.1 — Prompt Census | (structural audit — no external evidence needed) | | |
| Phase 1.2 — Positional Mapping | Liu et al. TACL 2024 (U-curve) | Wu et al. ICML 2025 (mechanism); Zhang et al. 2024 (RoPE root cause) | Anthropic ("up to 30% improvement" with docs top / query bottom); Google (context first, questions at end) |
| Phase 1.3 — Deduplication | Harada et al. 2024 (P^N) | | |
| Phase 1.4 — Cross-Rule Interference | Internal observations (2025) (Nr. 1, 6, 11) | | OpenAI GPT-5 ("model expends reasoning tokens reconciling contradictions") |
| Phase 2.1 — P^N Compliance Decay | Harada et al. 2024 (P^N model, up to 10) | Jaroslawicz et al. 2025 (extends to 500) | |
| Phase 2.2 — Positional Bias | Liu et al. TACL 2024 (empirical) | Wu et al. ICML 2025 (theoretical); Zhang et al. 2024 (root cause) | Anthropic + Google (documents top, queries bottom) |
| Phase 2.3 — Tool Complexity | Tam et al. EMNLP 2024 (JSON penalty) | BFCL ICLR 2025 (function-calling benchmarks); ComplexFuncBench 2025 (complex schemas); Liu et al. 2025 (prompt length) | OpenAI GPT-5 (tool call budgets, safe/unsafe distinction) |
| Phase 2.4 — Conditional Logic | Internal observations (2025) (Nr. 9, 10) | | |
| Phase 2.5 — Multi-Turn Degradation | Jaroslawicz et al. 2025 (earlier-instruction bias) | BFCL ICLR 2025 (multi-turn gap); Liu et al. TACL 2024 (context length) | OpenAI GPT-5 ("re-enforce instructions every 3-5 messages") |
| Phase 3 — Issue Mapping | (synthesis of Phase 1-2 findings) | | |
| Phase 4 — Solution Architecture | OpenAI 2025 (defense-in-depth); OWASP LLM01 (taxonomy) | Wallace et al. 2024 (instruction hierarchy); CFPB 2023 (externalize disclosures); Tam et al. 2024 (externalize structured output) | All providers (use structural delimiters — XML or equivalent); Google (scaffold reasoning dimensions for agentic prompts) |
| Phase 5 — Impact Estimation | Harada 2024 (P^N reduction); Liu TACL 2024 (repositioning gain) | ComplexFuncBench 2025 (tool simplification); Wallace 2024 (security consolidation) | |
| Phase 6 — Validation Plan | BFCL ICLR 2025 (evaluation methodology) | ComplexFuncBench 2025 (ComplexEval framework) | |

---

## Extrapolation Notes

The Assessor makes several operationalizations that go beyond what the cited papers directly tested. These must be flagged in every assessment:

1. **P^N beyond 10 instructions** — Harada tested up to 10. The SKILL.md tables showing P^N at N=25 and N=50 are extrapolations. Jaroslawicz (2025) provides evidence at higher instruction counts but uses a different task (keyword inclusion vs. behavioral rules).

2. **0.7 multiplier for middle-positioned rules** — Derived from Liu et al.'s U-shaped curve but the specific 0.7 factor is the Assessor's operationalization, not a figure from the paper.

3. **"27.3% JSON penalty"** — Cited in the SKILL.md from Tam et al. 2024. This specific number was not confirmed from publicly available search results. The paper clearly shows a significant penalty from JSON format restrictions on reasoning tasks, but the exact 27.3% figure needs verification against the full paper.

4. **"50-67% injection reduction" from security consolidation** — Cited in Phase 5. Wallace et al. report up to 63% improvement in system prompt extraction resistance and up to 30% jailbreak resistance. The "50-67%" range in the SKILL.md appears to be a synthesis of these figures, not a direct quote.

5. **State machine recommendation** — The SKILL.md correctly marks this as a HYPOTHESIS with indirect support from Jaroslawicz 2025.

---

## Provider Prompting Guides (Tier 4 Evidence)

Official guidance from LLM providers. Useful for model-specific recommendations but potentially biased and not peer-reviewed. Always flag which model family the guidance targets.

**Limitations common to all provider guides:**
- Commercial incentive to present their models favorably
- Recommendations may not transfer across model families
- Not independently validated — treat as practitioner guidance, not empirical evidence
- Can become outdated when new model versions change behavior

---

### Anthropic — Claude Prompt Engineering Guide

**Source:** [Anthropic Docs — Prompt Engineering](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview) (redirects to platform.claude.com)
**Model Family:** Claude 3 / 3.5 / 4 / Opus / Sonnet / Haiku
**Last Accessed:** 2026-02-11
**Pages Reviewed:** Overview, Be Clear and Direct, Use XML Tags, Long Context Tips

**Key Findings:**

1. **XML tags for prompt structure**
   - What they recommend: Use XML tags (`<instructions>`, `<example>`, `<formatting>`, `<document>`) to separate different prompt components. Nest tags for hierarchical content. Use consistent tag names and reference them in instructions (e.g., "Using the contract in `<contract>` tags...").
   - Why: Prevents Claude from mixing up instructions with examples or context. Improves parsing accuracy.
   - Assessor relevance: **Phase 1 check** — Does the prompt use structural delimiters? For Claude prompts, XML tags are the recommended pattern. Absence of structure in complex prompts is a risk signal.
   - Evidence quality: **Tier 4** — Provider recommendation, no quantified improvement cited.

2. **Long context: documents at TOP, queries at BOTTOM**
   - What they recommend: Place long documents and inputs (~20K+ tokens) near the top of the prompt, above queries, instructions, and examples.
   - Why: "Queries at the end can improve response quality by up to 30% in tests, especially with complex, multi-document inputs."
   - Assessor relevance: **Phase 2.2 cross-check** — Aligns with academic U-curve findings (Liu et al. 2024). The 30% claim reinforces positioning instructions at end of prompt for long-context scenarios. Note: this is provider's own testing, not independent research.
   - Evidence quality: **Tier 4** — Quantified claim ("up to 30%") but from internal testing, not peer-reviewed.

3. **Sequential numbered instructions improve compliance**
   - What they recommend: Provide instructions as numbered lists or bullet points "to better ensure that Claude carries out the task the exact way you want it to."
   - Why: Structured format reduces ambiguity and improves step-following.
   - Assessor relevance: **Phase 1 check** — Are instructions formatted as structured steps? Unstructured prose instructions are harder for models to follow reliably.
   - Evidence quality: **Tier 4** — Qualitative recommendation, no quantified effect.

4. **Ground responses in quotes for long documents**
   - What they recommend: For long document tasks, ask Claude to quote relevant parts before carrying out the task. "This helps Claude cut through the 'noise' of the rest of the document's contents."
   - Why: Forces the model to locate and reference specific content rather than hallucinating from general understanding.
   - Assessor relevance: **Phase 4 design principle** — For agents that reference long knowledge bases, include quote-grounding instructions to reduce hallucination risk.
   - Evidence quality: **Tier 4** — Practical recommendation, no quantified effect.

5. **Multi-document XML structure**
   - What they recommend: Wrap each document in `<document>` tags with `<document_content>` and `<source>` subtags, indexed by number.
   - Why: Provides clear document boundaries for the model.
   - Assessor relevance: **Phase 1 check** — For prompts with multiple knowledge sources or context documents, check if they're clearly delimited and indexed.
   - Evidence quality: **Tier 4** — Structural recommendation.

---

### OpenAI — GPT-5 Prompting Guide

**Source:** [OpenAI Cookbook — GPT-5 Prompting Guide](https://developers.openai.com/cookbook/examples/gpt-5/gpt-5_prompting_guide)
**Model Family:** GPT-5 (also broadly applicable to GPT-4.1+)
**Last Accessed:** 2026-02-11

**Key Findings:**

1. **Resolve conflicting instructions before deployment**
   - What they recommend: "GPT-5 expends reasoning tokens reconciling contradictions." Remove ambiguities around emergency procedures vs. standard workflows. Order instructions by precedence.
   - Why: Contradictions waste compute (reasoning tokens spent resolving conflicts instead of executing the task) and produce unpredictable behavior.
   - Assessor relevance: **Phase 1.4 cross-check** — Directly supports the cross-rule interference analysis. Instruction conflicts are not just a quality issue — they consume tokens and degrade performance. This is OpenAI's strongest endorsement that coherence matters.
   - Evidence quality: **Tier 4** — Provider-stated mechanism (reasoning token expenditure on contradictions), not independently measured.

2. **XML delimiters improve adherence**
   - What they recommend: "Structure prompts using XML delimiters: `<instruction_spec>` tags improve adherence."
   - Why: Clear structural boundaries help the model parse complex prompts.
   - Assessor relevance: **Phase 1 check** — Both Anthropic AND OpenAI recommend XML-style delimiters. This cross-provider agreement elevates confidence. Prompts without structural delimiters are a risk for both model families.
   - Evidence quality: **Tier 4** — Cross-provider agreement (Anthropic + OpenAI + Google) elevates effective confidence to Medium-High.

3. **Re-enforce format instructions every 3-5 messages in long conversations**
   - What they recommend: "Re-enforce markdown instructions every 3-5 messages to maintain adherence in long conversations."
   - Why: Instruction adherence degrades over multi-turn conversations.
   - Assessor relevance: **Phase 2.5 cross-check** — Aligns with academic multi-turn degradation findings (Jaroslawicz 2025). Provides a concrete mitigation: periodic reinforcement. Applicable to Phase 4 solution architecture for multi-turn agents.
   - Evidence quality: **Tier 4** — Practical guidance aligned with Tier 1 research.

4. **Set explicit tool call budgets and define safe vs. unsafe actions**
   - What they recommend: "Set fixed tool call budgets (e.g., maximum 2 calls)" and "Define safe vs. unsafe tool actions with different uncertainty thresholds."
   - Why: Prevents over-exploration and ensures dangerous tools have higher confidence gates.
   - Assessor relevance: **Phase 2.3 enhancement** — Tool safety assessment should check: (a) are tool call limits defined? (b) are sensitive tools gated by explicit confidence/precondition checks?
   - Evidence quality: **Tier 4** — Architectural recommendation from provider.

5. **Avoid vague maximization language**
   - What they recommend: Avoid phrases like "be THOROUGH" that "trigger over-exploration." Use direct, explicit, scoped language instead.
   - Why: Vague superlatives cause the model to over-invest in completeness at the expense of relevance and efficiency.
   - Assessor relevance: **Phase 1 check** — Flag vague behavioral instructions ("always be thorough," "give the best answer") as risk signals. These are effectively unbounded rules that waste tokens.
   - Evidence quality: **Tier 4** — Behavioral insight from provider.

---

### Google — Gemini Prompting Strategies

**Source:** [Google AI — Gemini Prompting Strategies](https://ai.google.dev/gemini-api/docs/prompting-strategies)
**Model Family:** Gemini 1.5 / 2.0 / 3.0
**Last Accessed:** 2026-02-11

**Key Findings:**

1. **Always include few-shot examples**
   - What they recommend: "We recommend to always include few-shot examples in your prompts."
   - Why: Examples demonstrate expected behavior more reliably than abstract instructions.
   - Assessor relevance: **Phase 1 check** — Does the prompt include examples for critical behaviors? Absence of examples for complex tasks is a risk signal, especially for Gemini prompts.
   - Evidence quality: **Tier 4** — Strong recommendation from provider. Aligns with general prompting research.

2. **Context at top, questions at bottom**
   - What they recommend: "For lengthy documents, provide all context first, then place specific questions at the end."
   - Why: Consistent with attention patterns — queries at end get highest attention.
   - Assessor relevance: **Phase 2.2 cross-check** — Three providers (Anthropic, OpenAI, Google) all recommend this pattern. Cross-provider consensus with academic research (Liu et al. 2024) makes this effectively Tier 2-level confidence.
   - Evidence quality: **Tier 4** individually, but cross-provider consensus + academic alignment = **effective High confidence**.

3. **Use consistent delimiters throughout**
   - What they recommend: Use XML tags or Markdown headings consistently. Do not mix delimiter styles.
   - Why: Inconsistent delimiters confuse parsing.
   - Assessor relevance: **Phase 1 check** — Check delimiter consistency. Mixed use of XML, Markdown, and raw text separators in the same prompt is a risk signal.
   - Evidence quality: **Tier 4** — Structural recommendation.

4. **Explicit grounding constraints for fact-dependent tasks**
   - What they recommend: "You are a strictly grounded assistant limited to the information provided in the User Context." Include knowledge cutoff awareness.
   - Why: Reduces hallucination for tasks requiring factual accuracy.
   - Assessor relevance: **Phase 2.7 (adversarial probing)** — Check if agents with knowledge bases have explicit grounding constraints. Absence = hallucination risk.
   - Evidence quality: **Tier 4** — Safety recommendation.

5. **Agentic system instructions: structure around reasoning dimensions**
   - What they recommend: For agentic workflows, structure system instructions around: logical decomposition, risk assessment (exploratory vs. state-changing), abductive reasoning for diagnosis, adaptability to contradictions, precision requirements.
   - Why: Agentic tasks require multi-dimensional reasoning that benefits from explicit scaffolding.
   - Assessor relevance: **Phase 4 design consideration** — For agentic prompts, check if reasoning dimensions are explicitly scaffolded. Generic "you are a helpful agent" preambles are insufficient.
   - Evidence quality: **Tier 4** — Architectural recommendation, no quantified effect.

---

### Meta — Llama Prompting Guide

**Source:** [Meta Llama Docs — Prompting](https://www.llama.com/docs/how-to-guides/prompting/)
**Model Family:** Llama 3 / 3.1 / 3.3
**Last Accessed:** 2026-02-11
**Status:** Page did not render text content (returned CSS/configuration). Key findings extracted from Meta's published chat template documentation and community resources.

**Key Findings (limited — from secondary sources):**

1. **Special token chat template**
   - What is known: Llama models use a specific chat template with special tokens (`<|begin_of_text|>`, `<|start_header_id|>`, `<|end_header_id|>`, `<|eot_id|>`) to delimit system, user, and assistant messages. Incorrect formatting causes significant performance degradation.
   - Assessor relevance: **Phase 1 check** — For Llama-family prompts, verify the chat template uses correct special tokens. Malformed templates are a critical failure mode unique to open-weight models.
   - Evidence quality: **Tier 4** — From model documentation, not the primary guide page.

2. **Few-shot prompting strongly recommended**
   - What is known: Meta recommends few-shot examples, particularly for structured output tasks.
   - Assessor relevance: Same as Gemini finding — absence of examples is a risk signal.
   - Evidence quality: **Tier 4** — Limited detail due to page rendering failure.

**Note:** This section has lower coverage than other providers. The primary documentation page failed to render. Should be updated when Meta's docs are accessible.

---

## Cross-Provider Comparison

Where providers agree, confidence is higher. Where they disagree, findings are model-specific.

| Topic | Anthropic (Claude) | OpenAI (GPT-4.1/5) | Google (Gemini) | Meta (Llama) | Consensus? |
|-------|-------------------|---------------------|-----------------|--------------|------------|
| **Use structural delimiters** | XML tags strongly recommended | XML `<instruction_spec>` tags improve adherence | XML or Markdown headings, be consistent | Special token template required | **Strong consensus** — all providers recommend structural delimiters |
| **Documents at top, queries at bottom** | "Up to 30% improvement" in long context | Not explicitly stated | Context first, questions at end | Unknown | **Moderate consensus** — Anthropic + Google explicit; aligns with academic research |
| **Numbered/structured instructions** | Sequential steps improve compliance | Explicit scoped language over vague | Specify desired structure | Unknown | **Moderate consensus** |
| **Few-shot examples** | Recommended for complex tasks | Not prominently featured | "Always include few-shot examples" | Recommended | **Moderate consensus** — Google strongest advocate |
| **Resolve instruction conflicts** | Not explicitly stated (but implied by XML structure) | "Model expends reasoning tokens reconciling contradictions" | Not stated | Unknown | **OpenAI-specific finding** — but aligns with cross-rule interference research |
| **Re-enforce instructions in long conversations** | Not stated | Every 3-5 messages | Not stated | Unknown | **OpenAI-specific finding** — aligns with multi-turn degradation research |
| **Tool call budgets and safety gates** | Not stated | Explicit budgets + safe/unsafe distinction | Not stated | Unknown | **OpenAI-specific finding** |
| **Grounding constraints** | Quote-grounding for long documents | Not stated | "Strictly grounded assistant" constraint | Not stated | **Anthropic + Google** — different mechanisms, same principle |

---

*Provider guides last updated: 2026-02-11*
*Coverage gaps: Meta Llama (primary docs inaccessible), OpenAI GPT-4.1 (server error during fetch)*
