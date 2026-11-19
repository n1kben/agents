# Location-independent agent configuration installer.
# Computes its own path, so `make install` works no matter where the repo is
# cloned. Links every skill flat into each harness's skills folder, because
# Claude Code only finds skills one level deep. A nested skill such as
# skills/vendored/poteto is linked as <skills folder>/poteto.

DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
SKILL_DIRS := $(HOME)/.claude/skills $(HOME)/.claude_personal/skills $(HOME)/.agents/skills

.PHONY: install uninstall sync autosync help

help: ## Show available targets
	@grep -E '^[a-z][a-zA-Z-]*:.*##' $(MAKEFILE_LIST) | sed -E 's/:.*## /\t/'

install: uninstall ## Link skills, CLIs and global instructions into Claude Code and Codex
	@mkdir -p $(HOME)/.claude $(HOME)/.claude_personal $(HOME)/.codex
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
	@mkdir -p $(HOME)/.local/bin
	@for bin in "$(DIR)"/bin/*; do ln -sfn "$$bin" "$(HOME)/.local/bin/$$(basename "$$bin")"; done
	ln -sfn "$(DIR)/AGENTS.global.md" "$(HOME)/.claude/CLAUDE.md"
	ln -sfn "$(DIR)/AGENTS.global.md" "$(HOME)/.claude_personal/CLAUDE.md"
	ln -sfn "$(DIR)/AGENTS.global.md" "$(HOME)/.codex/AGENTS.md"
	@git -C "$(DIR)" config core.hooksPath githooks

sync: ## Pull main; the post-merge hook reruns install
	git -C "$(DIR)" pull --ff-only --quiet

PLIST := $(HOME)/Library/LaunchAgents/local.agents-sync.plist

autosync: ## Run `make sync` every hour (launchd on macOS, cron elsewhere)
ifeq ($(shell uname),Darwin)
	@mkdir -p "$(dir $(PLIST))"
	@printf '%s\n' '<?xml version="1.0" encoding="UTF-8"?>' \
		'<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' \
		'<plist version="1.0"><dict>' \
		'<key>Label</key><string>local.agents-sync</string>' \
		'<key>ProgramArguments</key><array><string>/usr/bin/make</string><string>-C</string><string>$(DIR)</string><string>sync</string></array>' \
		'<key>StartInterval</key><integer>3600</integer>' \
		'<key>RunAtLoad</key><true/>' \
		'<key>StandardErrorPath</key><string>/tmp/agents-sync.log</string>' \
		'</dict></plist>' > "$(PLIST)"
	-@launchctl bootout gui/$$(id -u) "$(PLIST)" 2>/dev/null
	launchctl bootstrap gui/$$(id -u) "$(PLIST)"
else
	(crontab -l 2>/dev/null | grep -v agents-sync; echo '0 * * * * make -C "$(DIR)" sync >/dev/null 2>&1 # agents-sync') | crontab -
endif

uninstall: ## Remove only the links that point into this repo
	@for target in $(SKILL_DIRS); do \
		if [ -L "$$target" ]; then rm "$$target"; \
		elif [ -d "$$target" ]; then find "$$target" -maxdepth 1 -type l -lname "$(DIR)/skills/*" -delete; \
		fi; \
	done
	@find "$(HOME)/.local/bin" -maxdepth 1 -type l -lname "$(DIR)/bin/*" -delete 2>/dev/null || true
	@for f in "$(HOME)/.claude/CLAUDE.md" "$(HOME)/.claude_personal/CLAUDE.md" "$(HOME)/.codex/AGENTS.md"; do \
		if [ -L "$$f" ]; then rm "$$f"; fi; \
	done
