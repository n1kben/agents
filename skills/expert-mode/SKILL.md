---
name: expert-mode
description: Work through a hard problem the way an expert in its field would, establishing what is true before deciding what to do. Use only when `expert-mode` is specifically mentioned.
---

# Expert Problem Solving

Approach difficult problems as an exceptional expert in the relevant field would. Be rigorous, scientific, systematic and thorough. Prioritize correctness and quality over speed or superficial progress.

## Method

1. **Plan like an expert, in writing.** Before investigating, show a short plan:
   - **Field and method:** the discipline and the standard method an exceptional practitioner would use (for example, a threat model for a security review, or a minimal reproduction for a bug).
   - **Scope:** every part of the system involved, including the parts outside the code you were pointed at, such as linked PRs, configuration, other repos and the docs behind the problem.
   - **Questions:** what must be true or false for the answer to hold.
   - **Evidence:** for each question, the tool or source that can settle it.
   - **Done:** what result would let you stop.

2. **Understand before acting.** Establish the objective, context and constraints. Investigate the underlying problem rather than blindly accepting its framing. Identify root causes, dependencies, risks and relevant unknowns.

3. **Reason from evidence, and keep a claim ledger.** Every claim the answer depends on gets a tag:
   - **Verified:** with its evidence, such as a `file:line`, command output, a test result or a cited doc.
   - **Inferred:** with the reasoning and what would confirm it.
   - **Unknown:** with how to find out.

   An unknown that changes the answer must be investigated, not handed to the user, unless only the user can answer it. Then say so and ask. Show the tags inline in the final answer, for example `[verified: auth.go:79]`.

4. **Explore thoroughly.** Consider alternatives, challenge plausible conclusions and investigate important edge cases and failure modes. Don't settle for the first plausible solution when better approaches may exist. When the plan has independent areas, such as separate repos, services or open questions, investigate them in parallel with forked subagents. Each one owns its questions from the plan and returns ledger-tagged claims. Do small areas yourself.

5. **Validate conclusions with a fresh verifier.** Before reporting, start a fresh subagent (not a fork) and give it:
   - the ledger's claims, without your reasoning,
   - where the evidence lives (files, PRs, commands), and
   - the task of refuting each claim.

   Fix or drop every claim it overturns, and recheck any disputed claim yourself. In the answer, say what the verifier changed. Communicate the uncertainty that remains honestly.

**Principle:** Think like an expert. Investigate like a scientist. Establish what is true before deciding what to do.
