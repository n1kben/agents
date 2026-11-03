# Location-independent agent configuration installer.
# Computes its own path, so `make install` works no matter where the repo is
# cloned. Links every skill flat into each harness's skills folder, because
# Claude Code only finds skills one level deep. A nested skill such as
# skills/vendored/poteto is linked as <skills folder>/poteto.

DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
SKILL_DIRS := $(HOME)/.claude/skills $(HOME)/.claude_personal/skills $(HOME)/.agents/skills

.PHONY: install uninstall help

help: ## Show available targets
	@grep -E '^[a-z][a-zA-Z-]*:.*##' $(MAKEFILE_LIST) | sed -E 's/:.*## /\t/'

install: uninstall ## Link skills and global instructions into Claude Code and Codex
	@mkdir -p $(HOME)/.claude $(HOME)/.codex
	@for target in $(SKILL_DIRS); do \
		mkdir -p "$$target"; \
		find "$(DIR)/skills" -name SKILL.md | while read -r file; do \
			skill=$$(dirname "$$file"); \
			parent=$$(dirname "$$skill"); nested=0; \
			while [ "$$parent" != "$(DIR)/skills" ]; do \
				[ -f "$$parent/SKILL.md" ] && nested=1; \
				parent=$$(dirname "$$parent"); \
			done; \
			[ $$nested = 0 ] && ln -sfn "$$skill" "$$target/$$(basename "$$skill")"; \
		done; \
		echo "$$target: $$(find "$$target" -maxdepth 1 -type l | wc -l | tr -d ' ') skills"; \
	done
	ln -sfn "$(DIR)/AGENTS.global.md" "$(HOME)/.claude/CLAUDE.md"
	ln -sfn "$(DIR)/AGENTS.global.md" "$(HOME)/.codex/AGENTS.md"

uninstall: ## Remove only the links that point into this repo
	@for target in $(SKILL_DIRS); do \
		if [ -L "$$target" ]; then rm "$$target"; \
		elif [ -d "$$target" ]; then find "$$target" -maxdepth 1 -type l -lname "$(DIR)/skills/*" -delete; \
		fi; \
	done
	@for f in "$(HOME)/.claude/CLAUDE.md" "$(HOME)/.codex/AGENTS.md"; do \
		if [ -L "$$f" ]; then rm "$$f"; fi; \
	done
