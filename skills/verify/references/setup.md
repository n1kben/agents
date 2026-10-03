# Set up verification

`VERIFICATION.md` explains how to verify behavior in this project. Use this guide only when the file
does not exist.

Inspect the repository first. Ask the user one question at a time for facts you cannot infer, then
create the file with these sections:

- **Start:** commands and required services;
- **Access:** login steps and how to obtain credentials without storing them;
- **Test data:** how to create, allocate, reset, or find valid data for repeatable runs;
- **Isolation:** which state can be namespaced or reset and which changes require exclusive access;
- **Surfaces and methods:** relevant app, API, sandbox, preview, and Storybook URLs, plus how to
  exercise each production interface, replay its verification, and record video;
- **Evidence:** supporting capture tools, their installation commands, and where artifacts should be
  saved;
- **Cleanup:** how to undo complete and partially failed test changes.

Infer suitable methods from the repository and reuse its existing setup, fixtures, and commands.
For supported UI surfaces, use `e2e` as the default agentic harness and record its config, targets,
test glob, replay cache, and video command. Read [e2e](e2e.md) before configuring it. Defaults are:

- **Web:** `e2e` with its web engine;
- **Native iOS and Android:** `e2e` with its mobile engine;
- **Interactive CLI/TUI:** tmux and terminal recording;
- **API:** request scripts and terminal recording.

Use another UI harness only when `e2e` cannot drive the surface or the repository has an explicit
boundary against adding it. Record the reason in `VERIFICATION.md`.

Include project-specific facts an agent could not guess. Never store secrets in the file. Keep
approved features in the tracked `verification/` directory. Keep durable replays in the selected
harness's normal tracked location. Keep videos, traces, screenshots, reports, allocations, and
other generated run artifacts in `.verification/<run-id>/<behavior>/`, and ensure
`.verification/` is listed in `.gitignore`.
