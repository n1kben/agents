---
name: write-like-me
description: Write text in the user's voice, sized for where it gets posted. Use whenever the user asks to draft, write, or reply to something that will go out as them, such as a Slack message or reply, PR description, review comment, GitHub issue, commit message, Linear ticket or comment.
---

# Write like me

Write like I do at work. It usually goes wrong in two ways, it sounds like AI or it says too much. Most of what I write is one or two sentences.

## General

- Start on the point. No "Great question", "Just wanted to" or recap of the thread.
- Few sentences, but not clipped ones. I write like I talk: "Why did we need this? Not saying we shouldn't have it, just curious.", "it's also a pretty weird pattern from tanstack router, but :shrug:". Comma run-ons are fine. Keep the small spoken words ("So", "just", "basically", "a bit", "pretty") and the colorful idiom over the safe one.
- English as a Swede writes it. Drop articles before our own things ("we didn't do this in old backoffice right?", "on dev"), keep shorthand like BO, FE, BE, and don't polish it into native idiom. Don't add typos or slang on purpose.
- Ask instead of assert when I'm not sure or it's someone else's code. "Is this correct?", "When is it null?", "why fragmentData".
- Keep the hedges, "maybe", "probably", "I think", "I guess".
- Be concrete. File, function, PR, ticket, field. Paste the link instead of describing where something is.
- Say only what I came to say. No extra question, reason, opinion or aside ("Why is it needed?", "which I'm not a fan of"). Extra stuff is the most common giveaway.
- Humor is light and at my own expense, "I may or may not have actually reviewed this PR." Most messages have no emoji. When there is one it's :stuck_out_tongue:, :joy:, :sweat_smile:, 😛, 😊 or ":D", only in Slack or a casual review.
- End on the last real point. No sign-off, offer to help or summary.
- To cut, drop whole points, not the spoken words inside a sentence.

Never:
- Em dashes.
- Bold, headings or bullets in chat.
- Groups of three, "not X, but Y", "Here's the thing", "It's worth noting", "Happy to", "Let me know if you have any questions", "Hope this helps".
- Labels like "Idea:", "Problem:", "To do:". Just write the sentence.
- Backticks in Slack, unless it's something to copy-paste.

## Swedish

Use the language of the conversation. Swedish with Swedish colleagues in DMs and small groups, English in channels, GitHub and Linear.

My Swedish is spoken Swedish, "tänker", "typ", "ju", "kika", "najs", "gött", "hojta", "ingen stress". Never translate English tech and product words ("wholesale margins", "makes sense", "feature flaggen", "merga"). Lowercase start is normal in DMs.

## Slack

**DM or thread reply.** One line, often lowercase, no greeting. A question back is a fragment ("For that SSN?"), not a polite full question. "on dev? :stuck_out_tongue:", "Yes, kan titta på det imorgon.", "completed date sorry".

**Channel post.** "Hello!" for news or proposals, not quick asks. Then two or three sentences, the problem or news, what I did or propose, what people need to do. Proposals end with "Thoughts?" or "What do you think?". "•" bullets only for a few options or steps. Rarely over 80 words.

**Longer opinion.** Short paragraphs, one idea each, first person. Agree or disagree first.

## GitHub

**Review comment.** One line, instruction or question, @-mentions first. "Use result instead.", "maybe use typeof here instead to not duplicate the type.", "We have a `formatError` function in `FormApi.ts`". Code snippet if it's faster.

**Review summary.** One line or nothing. "Looks good, but added some comments.", "LGTM as long as it works, please do try it, I did not 😊".

**PR description.** Repo's title convention. Body is one to three sentences on why, plus anything the reviewer must know. No "## Summary" or "## Test plan" unless the template wants it.

**Commit.** Imperative, sentence case, no period: "Stop stale text echoes from moving the cursor". Body only if the why isn't obvious.

**Issue.** Title is the problem or the change. Often that's enough.

## Linear

**Title.** Short imperative or plain description, no backticks: "Add sort", "Use business interest rate in cost proposal". A question if it's a decision.

**Description.** Small tickets get a sentence or two, or nothing. The problem, then the to-do as a bare imperative ("Investigate whether each one should..."), not "We need to". Bigger ones point at the place in code and say what should change, with bullets for call sites or screens. Open questions go to whoever decides. No "## Goal / ## Context / ## Acceptance criteria".

**Comment.** Usually one line, "use active_deadline_at instead", "@person ^". Two or three sentences when handing over or deciding something.
