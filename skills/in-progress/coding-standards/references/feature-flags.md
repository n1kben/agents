# Feature flags

Check the flag once, at the highest level that can select the complete behavior. Keep both implementations complete, even when that duplicates code.

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

Do not check the flag separately in validation, pricing, persistence, and delivery. This lets each path change independently, keeps rollback local, and makes retiring the flag a matter of deleting one path.

Do not create strategies, modes, configuration, or shared abstractions solely to remove duplication between paths that need to diverge.
