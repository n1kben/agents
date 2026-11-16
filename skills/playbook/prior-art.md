# Prior art

## Research

Start with the user's sources. If there aren't enough, cast a wide net and score candidates on fit, quality, upkeep and openness, like how close their problem is to ours and whether you can read the source. Dig into the top few in parallel, one subagent each, and say why they won.

Read the real thing: their code or product, and what the authors wrote or said about it, like blog posts, talks and docs.

Name what each optimizes for and what it gives up. Take only what fits our priorities.

Mine their history, like commits, issues, tests and reverts, for lessons they already paid for.

Don't build yet. This playbook ends in a report, not a pull request.

## Handback

Hand back with this template.

```markdown
**{What we'd take, and how it fits ours}**

### {Tool}: {why it's worth learning from}
Optimizes for: {…} · gives up: {…}
{How it does it} · {better than ours} · {worse than ours}
Edge cases they hit: {…}

Skip: {what doesn't fit us, and why}
```
