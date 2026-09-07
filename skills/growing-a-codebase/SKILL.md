---
name: growing-code
description: Use when writing, changing, reviewing, or discussing code.
---

When growing code, try not to decide the structure ahead of time. Start with what you know, keep things together, and let the structure come out of the code as you learn more.

Start with a use case: a screen, route, API endpoint, job, whatever. Keep the code together and let it grow. If the file starts to feel too long, push into that feeling a bit. Is there actually a problem, or does it just seem like there should be one? Don’t split things up just because you can.

As the code grows, things may start to organize themselves: some data that keeps traveling together, an invariant you want to maintain, some behavior, or some other concept you can grab onto. Great. Give it a name, write some helper functions, put the related code together. If it helps, give the concept its own boundary, but keep it local to the use case. Finding a nice chunk of code does not mean it needs its own file, and giving something a boundary does not mean it needs to be shared.

When you find yourself asking “how do I share this?”, try to remember to ask why. Are these things actually the same, or are they similar? Do they really need to change together? We have a pretty strong habit of trying to get rid of duplication, but a little duplication is often a lot nicer than coupling things that want to change independently. Keep things local and let the sharing come to you. That tends to give you the nice situation where things that change together are together, and things that do not are not.

One nice consequence of this is that you can go into a use case, change some code, and mostly just worry about that code. You can test it there and, if it works, be pretty confident things are fine. Compare that with changing some shared thing and then having to ask: okay, who else is using this, and what did they need it to do? That is a pretty nice property to have.
