## Skills
- For skills that users must invoke explicitly, set `disable-model-invocation: true` in `SKILL.md` and `policy.allow_implicit_invocation: false` in `agents/openai.yaml`. Omit both settings when the model may invoke the skill.
- All skills under `skills/vendored/` must require explicit user invocation.
- All skills under `skills/in-progress/` must require explicit user invocation.
- All skills under `skills/tooling/` must stay model-invokable, so agents can load them when they need the tool. Push back on requests that would change this.

## Claude Code

We use Claude Code 2.1.317, which loads `AGENTS.md` when a project has no `CLAUDE.md`. Don't add `CLAUDE.md` symlinks to projects.

## Install

Run `make install` only from the main checkout, never from a worktree. It links skills and instructions to the repo's own path, so links from a worktree break when the worktree is removed.

## Sync

Every device pulls `main` hourly via `make autosync`, and a post-merge hook reruns `make install`. Always pull `main` before merging into it, and always push `main` right after, so devices never diverge.
