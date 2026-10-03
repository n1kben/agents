# Run verification

Read `VERIFICATION.md`, the approved `.feature` files, and the completed change. Execute every
scenario through the production interface.

## Coordinate

When more than one feature needs verification, act as the orchestrator. Before allowing state
changes, have a subagent for each feature report its required starting state, expected mutations,
and cleanup. Decide how the work should be isolated, allocate shared resources and identifiers, and
schedule the largest safe groups concurrently. Run conflicting or dependent features in ordered
waves; never assume every feature can run in parallel. If a subagent discovers an unexpected shared
state change, stop the affected work, restore clean state, update the schedule, and retry safely.

When `e2e` is selected, let its runner own workers, retries, browser contexts, and device leases.
The orchestrator still owns accounts, tenants, backend data, global settings, exclusive resources,
and separate MCP sessions or mobile targets for parallel feature agents. Read and follow
[e2e](e2e.md).

Give each discovery, rehearsal, retry, and recording attempt a fresh execution context with its
allocated data and artifact path. Keep values stable within an attempt, but do not hardcode unique
mutable identifiers in a replay. Assume a failed attempt changed state. Record created resources for
cleanup. An exact fixed value requires resettable or isolated state; otherwise report it as blocked.

## Verify and maintain the replay

Use the methods documented in `VERIFICATION.md`. On each verification pass, execute every selected
scenario before fixing the product. Collect all failures, fix them, then rerun every selected
scenario from the beginning. Repeat until everything passes. If a real blocker remains, report it
and stop.

As scenarios pass, create or update the durable replay in the selected harness's normal tracked
format and location. When a replay already exists, reuse it before exploring again. If it fails,
determine whether the product failed or the replay became stale; never change expected behavior
merely to make the replay pass.

Explore freely, but keep only the actions necessary for the successful scenario in the replay. When
an exploratory path is abandoned, discard it instead of encoding navigation back or compensating
actions. After every scenario passes, reset to fresh state and run each complete replay without
recording. If a replay fails, diagnose and repair it, then rehearse it again from the beginning.

## Record evidence

Do not record until every selected scenario and unrecorded replay passes. Then record one short
smoke video per selected recording method and confirm it is playable. If recording fails, install
missing components and retry. If it still fails, report verification as blocked.

Give each recording attempt fresh state and run each complete replay from the beginning, following
the same safe schedule. Give every selected scenario focused, watchable video evidence, grouped only
when the selected harness records several scenarios as one replay unit. If a recording run fails,
diagnose whether the product or replay failed, repair it, and restart that replay with fresh state;
never resume a recording halfway through. Every verification requires video evidence.

Save videos and useful supporting evidence such as screenshots, console errors, network failures,
traces, redacted requests and responses, status codes, server logs, command output, and native test
results under the allocated `.verification/` run directory. Never put secrets or personal data in
evidence.

## Report

In the final response:

- Lead with the video and a link, endpoint, or command where the user can try the change.
- Include the most useful supporting evidence for the verified surface.

Then give each scenario's result, link its evidence, and list material decisions made without prior
approval. Missing evidence is not a pass.
