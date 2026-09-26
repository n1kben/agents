# Agents

Shared Claude Code and Codex instructions and skills, managed independently of
any dotfiles.

## Setup

Clone anywhere, then symlink into Claude Code and Codex:

```bash
git clone <repository-url> ~/Developer/n1kben/agents
cd ~/Developer/n1kben/agents
make install
```

`make install` symlinks `skills/` to `~/.claude/skills` and `~/.agents/skills`.
It also links `AGENTS.global.md` to `~/.claude/CLAUDE.md` and
`~/.codex/AGENTS.md`. Run `make uninstall` to remove the links.

Because it's a plain directory symlink, you can point other tools/agents at the
same directory (e.g. `ln -sfn "$PWD/skills" <other-tool>/skills`).

## Layout

- `AGENTS.global.md` contains instructions shared across projects.
- `AGENTS.md` contains instructions for working in this repository.
- `skills/` contains locally authored skills.
- `skills/vendored/` contains third-party and source-derived skills.
- `skills/in-progress/` contains skills that are not ready for general use.
