---
name: coding-principles
description: When to move fast and when to slow down. Use when writing or designing code, schemas or data models.
disable-model-invocation: true
---

Code is cheap now. If it turns out wrong, you rewrite it. What is still expensive is a mistake you cannot undo, or one nobody notices. So move fast by default, and slow down only there.

## Move fast

### Do less

Every line is something someone has to read, test and change later. So get the smallest version working for real, then let it show you what is missing. (Small is about the code you write, not the code you read. Read everything the change touches first, because a small diff in the wrong place is just a second bug.) For everything else you are about to add, ask: who needs this today?

#### Speculating

You built for a need nobody has yet. It felt responsible, and now it is code someone has to keep working. If it is needed later, it is cheap to add then, and you will know more about what it should do.

For example, a config option nobody sets. Or error handling for a state that cannot happen.

#### Reinventing

You wrote something the codebase, the standard library, the platform or an installed dependency already does. Now there are two versions, and they will drift. Look before you write, and use what is there as it is.

For example, a date picker library where `<input type="date">` would do. Or a second retry helper in a repo that already has one.

#### Patching around it

You fixed the symptom where it showed up instead of the cause. It looks harmless, but the next agent reads your workaround as the way things are done here and copies it, and pretty soon it is everywhere. Fixing the cause used to be too expensive to bother with. It mostly is not anymore, so fix it there, even if the diff gets bigger.

For example, a null check at one call site when the function should never return null. Or a setTimeout to dodge a race.

### Decide later

Early on, you know the least. Every decision you make now is a guess, so make the ones you can take back and wait on the rest until the working version tells you. Before you commit to something, ask: what would it cost to undo this next month?

#### Abstracting

You saw two similar pieces and made them one. When they stop changing together, every change has to work around the other case. Duplication is cheaper than the wrong abstraction. Keep both, and merge them once they have proven to be the same.

For example, an exportCsv that grows an isPdf flag. Or a base class for two screens that almost matched.

#### Adding infrastructure

You picked something heavier than the problem needs, or added a queue, a cache or a new service before anything needed it. Each one is easy to add and hard to remove. Start with the simplest thing that works, and move up when something actually hurts.

For example, Postgres for an app SQLite would handle. Or a cache in front of a table with 200 rows.

#### Distributing

You made something async, eventually consistent or split across services before you had to. Now every change has to think about ordering, retries and half-finished work. Keep it synchronous, in one process and one transaction, until that stops working.

For example, a background job for work that takes 50ms. Or two services that both need to agree on an order's status.

### Keep it local

Changing code is fast now. Checking that a change did what you meant is the slow part. A change you can make and test in one place is one you can trust, so keep each change inside one feature, and keep the blast radius small. Share only what does not change. Before you share anything, ask: will this change when one of its users does?

#### Splitting by layer

You spread one feature across types.ts, utils.ts, constants.ts and hooks.ts. Now every change touches four files, and each one looks shareable, so other features start importing from it. Organize by feature instead, around what users see, like a route or a screen, and keep its code and tests together. When it gets too big, split it along those same lines.

For example, a 40-line component with its own types and hooks files. Or a constants file every feature imports from.

#### Exporting

You made something public in case it is useful elsewhere. Every export invites someone to depend on it, and then it cannot change freely. Keep things private until something actually needs them.

For example, an index.ts that re-exports a whole folder. Or a helper in a component file that three other components now import.

## Slow down

### Data integrity

Code can be rewritten. Data cannot be recovered once it is gone. So for every write, ask: what does this throw away, and could we ever need it? If the answer is "maybe", keep it. If it can be derived later, you can skip it.

#### Not recording it

The fact existed at write time and nobody stored it. When it happened, who did it, why. Nothing reads it today, and later someone asks and it is just not there.

For example, an account gets deleted and nothing says when or by whom. Or a sensor reading is stored without which device took it.

#### Summarizing it

You stored what you concluded instead of what happened. Conclusions depend on rules, and rules change. Store what happened and compute the conclusion. (Storing the conclusion too is fine for speed. It is a cache, and a cache can be rebuilt.)

For example, a flight stored as "delayed" instead of its scheduled and actual departure. Or a CI run stored as "passed" without which tests ran.

#### Overwriting it

The old value got replaced, either directly or because you point at something that changed later. Then "what was it at the time?" has no answer. Keep a copy or keep history, whichever the project can afford.

For example, a recipe edited in place, so last month's meal plan now lists ingredients nobody cooked. Or an invoice that points at a tax rate, and reprints wrong after the rate changes.

#### Conflating it

Two things that are different got stored as one. A shared record that each owner should have had its own copy of. An attribute used as an identity. A default standing in for "unknown". Merging later is easy. Splitting later is usually impossible, because you no longer know which was which.

For example, two patients merged because they share a name and birthday. Or a rating of 0 that means both "terrible" and "not rated yet".

#### Racing it

Two writers read the same thing, change it and save it, and the last save wins. The first change is just gone, and nothing says it ever happened. Give each writer its own record when you can. When they really have to share one, let the database serialize them.

For example, two tabs editing the same settings, where saving one quietly undoes the other. Or two workers bumping a counter by reading it and writing it back.

### Side effects

A call that changes something outside your system cannot be rolled back with your code. So before every such call, ask: what happens if this runs twice, in the wrong place, or on too much?

#### Running it twice

Retries, double clicks and restarted jobs all repeat calls. The other side cannot tell it is the same request unless you say so, usually with an idempotency key. A job can also die halfway, so write it to pick up what is left instead of starting over.

For example, a retry after a timeout that charges a card twice. Or an import that crashed at row 500 and sends the first 500 welcome emails again when it restarts.

#### Running it in the wrong place

Dev or a test talked to the real thing. Make the target come from config, with the safe one as the default.

For example, staging calling the production webhook. Or a test that emails a real customer.

#### Running it on too much

A query or loop matched more than you meant. Count what it will touch first, and do a dry run when you can.

For example, a webhook meant for one listing marks every listing sold. Or a cleanup meant for expired sessions that deletes users.

### Security

A hole can be patched. Whatever went through it before that cannot be taken back. So for every input and every read, ask: who could send this, and who is allowed to see it?

#### Trusting input

You put something from outside straight into a query, a shell command or HTML. Use the parameters and escaping the library already provides. Parse input into types where it enters, and trust those types inside.

For example, a search box pasted into SQL. Or an uploaded filename passed to a shell.

#### Skipping authorization

You checked that someone is logged in, not that they are allowed. Check ownership on every read and write.

For example, changing /orders/41 to /orders/42 shows someone else's order. Or an admin endpoint that only the UI hides.

#### Leaking it yourself

Secrets and personal data ended up somewhere they should not, almost never on purpose.

For example, an access token in an error log. Or an email address in an analytics event.

### Observability

You can only fix what you notice. A silent bug that writes bad data for a month turns a small mistake into a permanent one. So for every failure, ask: would anyone find out?

#### Swallowing errors

A catch that does nothing. The bug keeps running and nobody hears about it. If you do not know how to handle an error, let it fail loudly.

For example, a sync that skips every record it cannot parse. Or a job that retries forever without telling anyone.

#### Falling back silently

The fallback hides that something broke. Fall back if you want, but record that it happened.

For example, a failed fetch that shows "No results", so an outage looks like a quiet day. Or a missing price that defaults to 0.

#### Logging without context

The log says something failed but not what. Say what failed, for which record, and why.

For example, "Failed to save" with no id. Or a stack trace without the input that caused it.

### Backward compatibility

Once someone else depends on what you ship, breaking it breaks them, and a rollback does not undo that. So before you ship or change an API, URL, event or file format, ask: who reads this that I cannot update?

#### Designing it closed

You shipped a shape that can only change by breaking. Leave room to add: take and return objects instead of bare values, ignore fields you do not know, and treat enums as open.

For example, an endpoint that returns a bare array, so there is nowhere to put a cursor later. Or a client that crashes on a status value it has not seen.

#### Changing it in place

You renamed, removed or changed the meaning of something people use. Expand and contract instead: add the new next to the old, move everyone over, then remove the old. Inside one repo, migrate every caller in the same change.

For example, a renamed JSON field. Or a timestamp that switches from seconds to milliseconds.
