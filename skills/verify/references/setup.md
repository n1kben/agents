# Set up verification

`VERIFICATION.md` explains how to verify behavior in this project. Use this guide only when the file
does not exist.

Inspect the repository first. Ask the user one question at a time for facts you cannot infer, then
create the file with these sections:

- **Start:** commands and required services;
- **Access:** login steps and how to obtain credentials without storing them;
- **Test data:** how to create or find valid data;
- **Surfaces:** relevant app, API, sandbox, preview, and Storybook URLs;
- **Evidence:** useful logs and available capture tools;
- **Cleanup:** how to undo test changes.

Include project-specific facts an agent could not guess. Never store secrets in the file. Ensure
`.verification/` is listed in `.gitignore`.
