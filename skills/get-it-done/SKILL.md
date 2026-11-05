---
name: get-it-done
description: Use only when "get it done" is specifically mentioned.
---

# Get it done

**The goal is a result the user can trust without checking it themselves.**

It is tempting to call a task done when the code is written and the tests pass. That leaves the hard part for the user: running it and figuring out whether it actually works. Take that part off their hands.

## Decide what done means

Before starting, write down what done means as things someone could see happen. "The export button downloads a CSV with every row" can be checked. "Export works" cannot.

If you are doing this right, you will know how to demo the result before you change anything.

## Keep going

Make reversible decisions yourself, including product and design defaults. Ask before anything that cannot be undone, like deleting data, pushing, deploying, or sending messages.

If you are truly blocked, stop and say what blocks you, what you tried, and what you need. On long tasks, keep notes somewhere durable so an interruption does not mean starting over.

## Demo it

**This is the most important part.**

Run the real thing the way its users will. Passing tests are nice, but what happens when someone clicks the button? With an empty list? With bad input? Find out, and show it with a screenshot, a recording, before and after output, or a command the user can rerun.

It is easy to look at your own work and decide it is fine. When the result cannot be checked at a glance, ask a fresh subagent to try to break it.

If you cannot *demonstrate* that something works, it is not done. Say so.

## Hand off

Start with the demo. Go through the done list, giving each item its evidence or marking it not done. Then name the decisions the user may want to revisit, why you made them, and how to undo them. Finally, point out anything that still needs a human.
