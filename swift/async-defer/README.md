# Async cleanup with `defer`

## In 30 seconds

`defer` expresses scope-bound cleanup: register cleanup next to resource acquisition and run it when the scope exits, whether the operation returns normally or throws. In modern Swift, cleanup can cross an async boundary when the language/runtime version supports `await` in the deferred operation.

**Related Living chapter:** [Cancellation & cooperation](../concurrency/cancellation-and-cooperation/) — cleanup (`defer`) ≠ cancellation signal. Read that chapter for cooperative cancel; keep this note for lifetime/cleanup patterns.

The engineering question is not "can I put cleanup at the bottom?" It is "what lifetime owns this resource, and is cleanup guaranteed on every exit path?"

## Focus vs Defer

**Focus**

- scope-bound resource lifetime
- guaranteed cleanup on normal return and throw
- async cleanup such as closing a session or releasing an async resource
- interaction with cancellation
- keeping acquisition and cleanup structurally close

**Defer**

- treating `defer` as a replacement for actor isolation
- assuming `defer` automatically makes arbitrary work cancellation-safe
- hiding complex business workflows inside cleanup blocks

## Core pattern

```swift
func performWork() async throws {
    let session = try await startSession()

    defer {
        await session.close()
    }

    try await session.run()
}
```

**Toolchain scope:** `await` inside `defer` is valid only when your Swift language mode / compiler version supports it. Before treating this as the default production pattern, verify the deployment toolchain. If async defer is unavailable, keep acquisition/cleanup structurally close another way (explicit `defer` with sync cleanup, or shared cleanup helper on every exit path).

Read the code as a lifetime contract:

1. acquire the session
2. immediately define its cleanup
3. perform work
4. clean up when the scope exits

This is safer than duplicating cleanup before every `return` and in every `catch` path.

## `defer` vs `withTaskCancellationHandler`

They solve different problems.

`defer` is primarily about **scope exit and resource lifetime**. Use it when cleanup belongs to the lexical scope that acquired the resource.

`withTaskCancellationHandler` is about **reacting to task cancellation**. Use it when cancellation must trigger an explicit operation, especially when bridging APIs or stopping underlying work that does not automatically follow Swift task cancellation.

A useful interview distinction:

> `defer` guarantees scope-exit cleanup; a cancellation handler defines cancellation-specific behavior. They may be used together when a resource has both a normal lifetime and explicit cancellation semantics.

## Pitfall: cancellation is not magic cleanup

A cancelled task is cooperative. The task and the APIs it calls must observe cancellation. Do not assume that registering `defer` cancels a network request, closes a stream at the correct semantic moment, or rolls back a domain mutation.

Ask three questions:

- What resource was acquired?
- Which scope owns its lifetime?
- Does cancellation require behavior different from ordinary scope exit?

## Senior-level example

For an AI streaming pipeline, the scope may own a model/session handle and a stream consumer. `defer` can guarantee session cleanup. A cancellation handler may separately propagate cancellation to an underlying provider request. Domain state should still commit only through an explicit deterministic path; cleanup must not silently mutate product truth.

## Interview answer

`defer` is a lifetime tool. I place cleanup immediately after successful acquisition so every later return or throw shares the same cleanup path. For async resources, async cleanup keeps that ownership structure instead of scattering `await close()` across branches. I still reason about cancellation separately: if the underlying operation needs an explicit cancel signal, I use cancellation handling rather than assuming scope cleanup is enough.

## Exercise

Implement an async session with these paths:

- success
- thrown error
- task cancellation

Verify which cleanup runs in each path. Then add explicit cancellation behavior and explain why it is separate from scope-exit cleanup.

## Apple / Swift references

- Swift language and release documentation for the compiler version used by the project
- Swift Concurrency documentation
- `withTaskCancellationHandler(operation:onCancel:isolation:)`

Before using async work inside `defer` in production, verify the deployment toolchain and Swift language mode that provide the feature.

## Q&A cards

**Q: What problem does `defer` solve?**  
A: It ties cleanup to lexical scope exit and keeps cleanup close to acquisition.

**Q: Is `defer` a cancellation primitive?**  
A: No. It handles scope-exit cleanup. Cancellation-specific behavior belongs in cancellation handling when required.

**Q: Why is async cleanup useful?**  
A: Some resources require asynchronous release or close operations; async cleanup preserves structured lifetime reasoning without duplicated cleanup branches.

**Q: What is the senior-level concern?**  
A: Resource ownership, cancellation semantics, idempotent cleanup, and keeping domain mutation out of implicit cleanup paths.
