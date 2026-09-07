---
name: shaping-an-api
description: Use when writing, changing, reviewing, or discussing code.
---

When designing an API, start by asking what people are actually trying to do. What is the normal case? Try to make that really nice. Use the simplest API that gets the job done. Not everything needs the same shape, and a smaller API is often nicer because there is simply less to think about.

From there, ask what can go wrong. Are there states that do not make sense, some invariant that should always hold, or an expected way the operation can fail? See if you can choose the representation and public API so those things are visible in the types. Make impossible states impossible where you can. When raw input crosses the boundary, parse, don’t validate. If failure is expected, make the error a value.

Then think about what people actually need to know. Hide the details they do not need, and expose as little as possible, but no less. A nice API is often a deep module: there can be quite a lot going on behind a pretty small interface. And if you hide all the details and then start adding getters and setters for them, that is a bad sign. Maybe those details should just be available.

One nice thing I usually do when there really are more advanced cases is have two APIs. So maybe there is `SomeModule` with the small, nice API that most people want, and `SomeModule.Advanced` with all the knobs. The simple one is implemented in terms of the advanced one, so there is still just one thing underneath. Most people never need to know about that, but when someone actually has the weird case, there is somewhere to go. I would wait until I actually have those cases though. You do not need to add a bunch of knobs just because someone might want them someday.
