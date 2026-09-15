# Location-independent agent configuration installer.
# Computes its own path, so `make install` works no matter where the repo is
# cloned. Symlinks the skills and global instructions into Claude Code and Codex.

DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

.PHONY: install uninstall help

help: ## Show available targets
	@grep -E '^[a-z][a-zA-Z-]*:.*##' $(MAKEFILE_LIST) | sed -E 's/:.*## /\t/'

install: ## Symlink skills and global instructions into Claude Code and Codex
	@mkdir -p $(HOME)/.claude $(HOME)/.agents $(HOME)/.codex
	ln -sfn "$(DIR)/skills" "$(HOME)/.claude/skills"
	ln -sfn "$(DIR)/skills" "$(HOME)/.agents/skills"
	ln -sfn "$(DIR)/AGENTS.md" "$(HOME)/.claude/CLAUDE.md"
	ln -sfn "$(DIR)/AGENTS.md" "$(HOME)/.codex/AGENTS.md"

uninstall: ## Remove the skills and global instruction symlinks
	rm -f "$(HOME)/.claude/skills" "$(HOME)/.agents/skills"
	rm -f "$(HOME)/.claude/CLAUDE.md" "$(HOME)/.codex/AGENTS.md"
