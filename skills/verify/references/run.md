# Run verification

Read `VERIFICATION.md`, the approved `.feature` file, and the completed change. Execute every
scenario through the production interface.

For browser behavior, use Playwright. Record a focused, watchable video with visible actions. Save
useful screenshots, console errors, network failures, and traces. For APIs, save redacted commands,
requests, responses, status codes, and relevant server logs. For other code, save command output and
a plain-language outline of the behavior exercised. Never put secrets or personal data in evidence.

Write `.verification/<behavior>.report.md`. For each scenario, record `PASS`, `FAIL`, or `BLOCKED`
and link its evidence. Include dev-server, preview, sandbox, or Storybook links when available, plus
material decisions the implementation made without prior approval. Missing evidence is not a pass.

Run every scenario before fixing anything. Collect all failures, fix them, then rerun every scenario
from the beginning. Repeat until everything passes or a real blocker remains.
