# Feature Flags

**Prefer code you can delete over code you must untangle.**

Branch once at the highest level that can choose the complete behavior. Keep both implementations whole, even with substantial duplication.

```text
if newCheckoutEnabled then
    order
        |> validateCheckoutV2
        |> priceCheckoutV2
        |> reserveInventoryV2
        |> confirmCheckoutV2
else
    order
        |> validateCheckoutV1
        |> priceCheckoutV1
        |> reserveInventoryV1
        |> confirmCheckoutV1
```

Do not spread the flag through validation, pricing, persistence, and delivery. Whole paths evolve independently, rollback is local, and removing the flag means deleting one path instead of untangling conditions throughout the system.

Do not create strategies, modes, configuration, or abstractions merely to remove duplication between paths whose purpose is to diverge.
