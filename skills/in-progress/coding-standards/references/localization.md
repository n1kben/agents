# Localization

Name translation keys for the screen, route, view, or use case, not the current source-language text. Two controls labeled "Done" may need different translations later. Give them separate scoped keys unless they represent one concept that must always change together.

```text
checklist-detail.toolbar.done
new-bucket.toolbar.done
```

Translate complete messages instead of joining translated fragments. Use the localization system for interpolation, plurals, and word order. Give accessibility text its own contextual message.
