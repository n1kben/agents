---
name: get-it-done
description: Use only when "get it done" is specifically mentioned.
---

Definition of done: qa found nothing left to break, the PR is open, CI is green by fixing not skipping, and demo ran on the PR after the last change.

# Get it done

**The goal is to take a task all the way to a demoed pull request with green CI, without the user's help along the way.**

It is tempting to call a task done when the code is written and the tests pass. That leaves the hard part for the user: running it and figuring out whether it actually works. Take that part off their hands.

## Keep going

Make reversible decisions yourself, including product and design defaults. Ask before anything that cannot be undone, like deleting data, merging, deploying, or sending messages.

If you are truly blocked, stop and say what blocks you, what you tried, and what you need.

## Finish it

1. Test the change.
2. Demo the change. This is the most important part.
3. Open a pull request with the proof from the demo.
4. Get CI green.

## Hand off

Start with the demo. Go through the done list and what is not done. Then name the decisions the user may want to revisit, why you made them, and how to undo them. Finally, point out anything that still needs a human.
