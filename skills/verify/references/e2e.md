# Verify UI behavior with e2e

Use `e2e` for supported web, iOS, and Android surfaces. Follow the installed `e2e` skill and project
configuration; this reference defines how it participates in verification.

When the project is not configured yet, use `npx e2e init` and choose the engine inferred from the
repository. Reconcile its generated config, commands, and test location with repository conventions.

## Durable behavior and replay

Keep the approved Gherkin feature under `verification/`. The durable executable replay is the
committed TypeScript test under the project's configured `e2e` test glob. Verified `agent.act`
action traces live in `.e2e/cache/`; commit the entries needed for fast shared replay. They are an
optimization owned by `e2e`, not a replacement for the test.

Have the orchestrator allocate collision-safe run values such as registration numbers, then pass
them to the test through `unique(value)` so cached actions substitute the current attempt's value.
Use fixtures and teardown for data creation and cleanup. The orchestrator must still allocate
accounts, tenants, and shared backend state that the runner cannot isolate.

Some run-time values cannot be recorded safely and cause the replay to hand control back to the
agent. That is acceptable when the live step is intentional, bounded, and followed by a
deterministic assertion.

## Explore and write

Give each feature agent its own `e2e mcp` session and, on mobile, its own target and device. The MCP
server defaults to four simultaneous sessions; raise its limit or schedule discovery in waves.
Explore freely in the session, then write or update the TypeScript test; MCP exploration is not
itself a test or replay.

Distill the successful path. Use exact `screen` actions when the interaction is known and a bounded
`agent.act` for a goal whose path may vary. Follow every `agent.act` with a deterministic `expect`
that proves its result and permits the action trace to be cached. Avoid agent judgments when an
exact assertion can prove the behavior.

A passing trace can still contain an exploratory detour. Review the action sequence and count. When
it is not focused enough for the final video, replace the broad `agent.act` with exact `screen`
actions or a narrower goal with a new cache identity, then rerun in read-write mode to record a
clean verified entry.

## Rehearse and record

Run the selected tests without video in read-write cache mode until every scenario passes. Then run
them again without video to prove the cache replays against fresh state. Inspect the report: every
unexpected cache miss must be repaired. Record which steps intentionally remain live because their
run-time data or interaction cannot be replayed safely.

Only after every selected test passes, make the final evidence run with fresh data, no retries,
video enabled, and cache configured read-only when practical. Use the project's safe worker
schedule and an output directory allocated under `.verification/`, for example:

```bash
npx e2e run tests/<behavior>.e2e.ts --strict-cache --retries 0 \
  --video=on --output .verification/<run-id>/<behavior>
```

An expected model call for an explicitly uncached step is valid in the final video. An unexpected
model fallback, distracting detour, or failure is not. Diagnose whether the product, test, or cache
is stale; update it in a non-recording run, allocate fresh state, and record the complete replay
again from the beginning.

`--strict-cache` rejects an existing stale entry, but a missing or deliberately uncached step may
still run live. The report's cache details and model-call count distinguish intended live work from
an accidental fallback.

Web recordings are WebM and mobile recordings are MP4. Videos are not secret-masked. Keep secrets
off screen and retain the `e2e` report and useful traces beside each video.
