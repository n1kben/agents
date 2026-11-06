# Agents

Shared Claude Code and Codex instructions and skills, managed independently of
any dotfiles.

## Setup

```bash
git clone <repository-url> ~/Developer/n1kben/agents
cd ~/Developer/n1kben/agents
make install
```

`make install` links the skills and global instructions into Claude Code and
Codex, and the CLIs in `bin/` into `~/.local/bin`. `make uninstall` removes the
links.

## Layout

- `AGENTS.global.md` contains instructions shared across projects.
- `AGENTS.md` contains instructions for working in this repository.
- `bin/worktreeinclude` copies the gitignored files listed in `.worktreeinclude` into a git worktree. Run it as the setup hook of any tool that creates worktrees.
- `skills/<name>/` contains locally authored general-purpose skills.
- `skills/tooling/` contains operational skills for tools that agents may invoke automatically.
- `skills/vendored/` contains third-party and source-derived skills.
- `skills/in-progress/` contains skills that are not ready for general use.
