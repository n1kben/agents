# Primary works

## Papers

1. Evan Czaplicki, [“Elm: Concurrent FRP for Functional GUIs”](https://elm-lang.org/assets/papers/concurrent-frp.pdf), senior thesis, 2012. Introduces Elm through two linked goals: purely functional graphical layout and concurrent functional reactive programming. The thesis is the clearest early evidence of explaining a language through a practical GUI problem, related work, formal semantics, implementation, and examples.
2. Evan Czaplicki and Stephen Chong, [“Asynchronous Functional Reactive Programming for GUIs”](https://doi.org/10.1145/2499370.2462161), PLDI 2013. Refines the concurrency idea for publication: programmers can explicitly relax global event ordering so long-running work does not make an interface unresponsive.

These are historical sources. Elm later moved away from signals and FRP terminology, as explained in [“A Farewell to FRP”](https://elm-lang.org/news/farewell-to-frp).

## The Elm Guide

[An Introduction to Elm](https://guide.elm-lang.org/) is Evan’s book-length teaching source. The [public repository](https://github.com/evancz/guide.elm-lang.org) describes it as a coherent book updated in editions. Its contribution guidance asks for the reader’s background, learning goal, route into the guide, and exact confusion—strong evidence for audience-specific, structured feedback rather than sentence-by-sentence crowd editing.

Recurring teaching choices:

- examples and visible programs before terminology;
- one conceptual layer at a time;
- ordinary language around types and effects;
- friendly warnings about common wrong turns;
- deeper theory moved to appendices or later chapters;
- an architecture explained through `Model`, `update`, and `view` before extensions.

See `guide-index.csv` for the chapter inventory.

## Elm news and release writing

The [Elm news archive](https://elm-lang.org/news) combines product explanation, release notes, history, and argument. Particularly useful pieces include:

- [“Interactive Programming”](https://elm-lang.org/news/interactive-programming) — defines terms before showing hot-swapping and shorter feedback loops.
- [“Compiler Errors for Humans”](https://elm-lang.org/news/compiler-errors-for-humans) and [“Compilers as Assistants”](https://elm-lang.org/news/compilers-as-assistants) — treats error messages as a human interaction design problem.
- [“A Farewell to FRP”](https://elm-lang.org/news/farewell-to-frp) — removal of concepts as design progress; anticipates opposite reader reactions.
- [“How to Use Elm at Work”](https://elm-lang.org/news/how-to-use-elm-at-work) — adoption through a small, low-risk project rather than an all-at-once rewrite.
- [“The Perfect Bug Report”](https://elm-lang.org/news/the-perfect-bug-report) — tooling can capture the information normally lost in vague reports.
- [“The Syntax Cliff”](https://elm-lang.org/news/the-syntax-cliff) — compiler guidance based on recognizable mistakes and migration paths.
- [“Road to Elm 1.0”](https://elm-lang.org/news/faster-builds) — small non-breaking releases, measured compiler performance, and a direct request for real-world reports.

See `elm-news-index.csv` for the full locally indexed set.

## Other primary archives

- [Evan’s GitHub profile](https://github.com/evancz) and [public gists](https://gist.github.com/evancz) show experiments, teaching notes, sketches, and reference material. See `gists-index.csv`.
- [The Elm Architecture tutorial](https://github.com/evancz/elm-architecture-tutorial) gives a compact statement of `Model`, `update`, and `view` as the common structure of Elm programs.
- [Elm Discourse profile](https://discourse.elm-lang.org/u/evancz/activity) provides the public forum corpus indexed in `discourse-index.csv`.
- [“Rethinking Database Programming”](https://acadia.engineering/blog/rethinking-database-programming) and the [Acadia release announcement](https://discourse.elm-lang.org/t/what-if-sql-was-like-elm-acadia-release/10888) show the current extension of Elm’s type-safety and tool-design ideas into database work.
