---
name: localization
description: Guidance for naming and composing localizable messages without losing context. Use when adding or reviewing translations, message keys, interpolation, plurals, accessibility copy, or localized UI text.
---

Translation identity belongs to the screen, route, view, or use case—not to the current source-language words. Two controls that both say “Done” may need different translations later, so keep separate scoped keys unless they express one concept that must always change together.

```text
checklist-detail.toolbar.done
new-bucket.toolbar.done
```

Translate complete messages rather than joining translated fragments. Let the localization system handle interpolation, plurals, and word order. Treat accessibility text as its own contextual message.
