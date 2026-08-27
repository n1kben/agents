# Skills

Claude Code and Codex skills, managed independently of any dotfiles.

## Setup

Clone anywhere, then symlink into Claude Code and Codex:

```bash
git clone <repository-url> ~/Developer/n1kben/skills
cd ~/Developer/n1kben/skills
make install
```

`make install` symlinks this repo's `skills/` directory (wherever it lives) to
`~/.claude/skills` and `~/.agents/skills`, so only the skills themselves are
exposed — not the README, Makefile, or other repo metadata. Run `make uninstall`
to remove the links.

Because it's a plain directory symlink, you can point other tools/agents at the
same directory (e.g. `ln -sfn "$PWD/skills" <other-tool>/skills`).
