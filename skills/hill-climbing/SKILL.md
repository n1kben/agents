---
name: hill-climbing
description: Hill-climbing playbook. Use when improving a measurable number, such as speed, size, memory, error rate, or a score.
---

# Hill climbing

Pick one metric, which direction is better, and a target. Find a case that shows the problem the way users hit it.

Write one command that prints the metric. Use the median of several runs, so noise doesn't look like a win. Don't change the command during the run. Record the baseline.

Make one change at a time. Keep it only if the metric moves beyond noise and the tests pass; otherwise revert all of it. Log every attempt and its result, and read the log before the next one.

Stop when the target is met. Don't lower the target to reach it, and don't trade away correctness or simplicity for the number. On a plateau, try a different kind of change before giving up.
