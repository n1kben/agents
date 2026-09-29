## Skills
- For skills that users must invoke explicitly, set `disable-model-invocation: true` in `SKILL.md` and `policy.allow_implicit_invocation: false` in `agents/openai.yaml`. Omit both settings when the model may invoke the skill.

## Tool-oriented sub-agents

Delegate mechanical, tool-heavy work—such as Playwright browser interaction, UI walkthroughs, screenshot collection, log inspection, repository searches, and routine verification—to a sub-agent using a fast, lightweight model with low reasoning effort by default.

Provide a concrete task, relevant context, expected outcome, and evidence to return. Use a more capable model when the work requires complex debugging, architectural judgment, security analysis, or nuanced visual evaluation.
