# Run verification

Read `VERIFICATION.md`, the approved `.feature` file, and the completed change. Execute every
scenario through the production interface.

For browser behavior, use Playwright and record the complete verification run as a focused,
watchable WebM with visible actions. Before testing, record a short smoke video and confirm the WebM
is playable. If it is not, install missing components and retry; otherwise proceed. If recording
still fails, report verification as blocked. Do not omit the video. Save useful screenshots,
console errors, network failures, and traces. For APIs, save redacted commands, requests, responses,
status codes, and relevant server logs. For other code, save command output and a plain-language
outline of the behavior exercised. Never put secrets or personal data in evidence.

In the final response:

- For browser behavior, lead with the video and a link where the user can try the change.
- For API behavior, lead with the request and response log plus the endpoint or sandbox.
- For other behavior, lead with the checks performed and their output.

Then give each scenario's result, link its evidence, and list material decisions made without prior
approval. Missing evidence is not a pass.

Run every scenario before fixing anything. Collect all failures, fix them, then rerun every scenario
from the beginning. Repeat until everything passes. If a real blocker remains, report it and stop.
