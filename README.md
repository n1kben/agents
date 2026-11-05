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
Codex. `make uninstall` removes the links.
