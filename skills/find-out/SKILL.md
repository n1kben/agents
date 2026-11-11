---
name: find-out
description: Settle an unknown instead of guessing. Use before acting on an assumption, before copying a pattern, or before asking the user something you could find out.
---

Don't guess, and don't ask the user what you can find out. Ask them only about what they want.

- Investigate how: start where it's triggered and follow each step to what does the work.
- Investigate what's used: find every place that does it, not just the first, and say which is the supported path and which are exceptions.
- Investigate why: read the history back to the commit, PR or issue that made the decision. Say "because" only when you can quote the reason.
- Research: go to the primary source, such as the paper, the spec or the docs for the version in use.
- Spike: run the smallest throwaway test that still looks like the real case, and make sure it can fail.
- Prototype: build three versions you'd each ship, each a different direction rather than a tweak. Make each fully work with realistic content, away from production code. Show one at a time in its real context with instant switching, and try each yourself first. Give each one's strength and cost, and let the user pick.

Investigating and researching change nothing. Spikes and prototypes are throwaway.

Back each claim with what you saw, and mark the rest as guesses.
