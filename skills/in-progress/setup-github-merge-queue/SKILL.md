---
name: setup-github-merge-queue
description: Configure, repair, or tune a GitHub repository's merge queue and the CI workflows it requires. Use only when explicitly invoked to set up merge-queue-based landing for a project.
disable-model-invocation: true
---

# Set up a GitHub merge queue

Configure the repository so GitHub validates approved pull requests against current main and lands
them asynchronously. Read the repository instructions first.

## Boundaries

- Support GitHub Actions. For another CI provider, report the required integration and stop.
- Never weaken existing protections, checks, approvals, bypass restrictions, or security controls.
- Never enable the queue before every required workflow can report a check for `merge_group`.
- Never enqueue or merge application pull requests as part of setup.
- Show the exact ruleset change and confirm it immediately before changing GitHub settings.
- Do not ask for credentials in chat. Use the user's existing `gh` authentication.

## Inspect

1. Resolve the repository and default branch with `gh`; confirm authentication, queue eligibility,
   and repository-administration access.
2. Read repository and inherited rulesets, legacy branch protection, required checks, merge methods,
   bypass actors, and any existing queue rule.
3. Map each required check to its GitHub Actions workflow.
4. Check those workflows for `merge_group` support and PR-only values such as
   `github.event.pull_request`, `github.head_ref`, PR head SHAs, and PR-number concurrency keys.

If the repository has no required checks, show the checks observed on recent successful pull
requests and ask which should gate the queue. Do not activate an unverified queue.

Propose the workflow changes and exact ruleset JSON. Use these starting settings unless repository
evidence or the user indicates otherwise:

- `REBASE`, `ALLGREEN`, one PR per merge group, no wait, and a 60-minute check timeout.
- Ask for safe CI concurrency; if unknown, propose `5` as an unmeasured starting point.
- Ask whether emergency bypass actors should be carried over; do not infer them.

Keep merge-queue configuration in a dedicated repository ruleset targeting the exact default branch.

## Phase 1: bootstrap CI

Skip this phase when every required workflow on the default branch already supports merge groups.

1. Add `merge_group: { types: [checks_requested] }` to each required workflow without replacing its
   existing triggers.
2. Adapt PR-only expressions for both events without broadening permissions or secret access.
3. Validate with project tooling and `actionlint` when available.
4. Commit the focused change, push it, and open a bootstrap pull request.
5. Stop and ask the user to invoke the skill again after that pull request reaches the default branch.

Do not activate early: GitHub reads queue workflows from the default branch.

## Phase 2: activate or repair the ruleset

Proceed only when the default branch contains `merge_group` triggers for every required workflow.

1. Re-read live settings and workflows.
2. Show the semantic diff and complete ruleset JSON, then ask for confirmation.
3. Create the dedicated ruleset or update only the identified queue ruleset with `gh api`. Preserve
   the complete prior document so omitted fields are not lost and rollback is possible.
4. Fetch it again and verify the branch target, enforcement, settings, required checks, and existing
   protections. Restore the prior document if anything was weakened.

Do not test activation by queueing or merging an unrelated pull request. Offer a separate dry run
using a user-selected pull request.

## Finish

Report the bootstrap PR or ruleset link, final settings, checks, validation, next action, and rollback
path. Do not claim end-to-end success until a merge-group check has run.
