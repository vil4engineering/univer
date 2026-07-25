# NSManagedObjectID — persist across launches?

Notes for **Storage & Persistence**. Source: Saved triage (interview-style post). Related: [Storage README](../README.md) (**Q33**, **Q54**), playground [`CoreDataConcurrencyInterview`](../CoreDataConcurrencyInterview.playground/).

---

## In 30 seconds

`NSManagedObjectID` is Core Data’s opaque identity for a managed object. You may pass it across contexts/threads, and you may archive a **permanent** ID (via `uriRepresentation()`) to reopen the same row after relaunch. A **temporary** ID (object not saved yet) is not stable across save or process death.

---

## Two jobs of the same type

| Use | What you do | Survives app kill? |
|-----|-------------|--------------------|
| Cross-thread / cross-context | Pass `objectID`, then `existingObject(with:)` / `object(with:)` on the target context | N/A (same process) |
| “Open this row later” | Store `objectID.uriRepresentation()` (string/URL), restore via coordinator | Yes — only if ID was **permanent** |

Do not serialize the `NSManagedObject` itself. Do not keep a live object across process death.

---

## Save URI (permanent only)

Apple: if the object is not saved yet, the ID (and its URI) is temporary and **changes** on save. Check `isTemporaryID` (or save / `obtainPermanentIDs(for:)` first).

```swift
func saveObjectID(_ object: NSManagedObject) {
    let objectID = object.objectID
    guard !objectID.isTemporaryID else { return }

    let uri = objectID.uriRepresentation().absoluteString
    UserDefaults.standard.set(uri, forKey: "savedObjectID")
}
```

`UserDefaults` is fine for a single bookmark string. Prefer a clearer store if this is product state, not a demo.

---

## Restore after relaunch

```swift
func fetchSavedObject(context: NSManagedObjectContext) -> NSManagedObject? {
    guard
        let objectIDString = UserDefaults.standard.string(forKey: "savedObjectID"),
        let objectURL = URL(string: objectIDString),
        let coordinator = context.persistentStoreCoordinator,
        let objectID = coordinator.managedObjectID(forURIRepresentation: objectURL)
    else {
        return nil
    }

    return try? context.existingObject(with: objectID)
}
```

Prefer `existingObject(with:)` when the row might be gone: it throws if the object is missing. `object(with:)` always returns a fault and can surprise you later when the fault fires.

Run context work on that context’s queue (`perform` / main context rules) — same as any Core Data access.

---

## Pitfalls

- Temporary ID archived → URI worthless after save / relaunch.
- Store deleted or migrated → URI may not resolve; handle `nil` / throw.
- Same URI assumes the **same store** (path / model identity). Do not treat it as a cloud primary key.
- Cross-thread still applies: restore on the context you will use; never hop with a live `NSManagedObject`.

---

## Interview Q&A

### Q1
- **Question:** What is `NSManagedObjectID`? Can we keep it after the app closes?

- **Answer:** Opaque Core Data identity. Across threads — yes, pass the ID and re-fault. Across launches — yes only for a **permanent** ID via `uriRepresentation()` → `managedObjectID(forURIRepresentation:)` → `existingObject(with:)`. Temporary IDs change on save and must not be archived.

### Q2
- **Question:** `object(with:)` vs `existingObject(with:)` when restoring?

- **Answer:** `existingObject(with:)` fails if the row is gone. `object(with:)` returns a fault even when deleted — prefer existing when the bookmark may be stale.

---

## Official docs

- [uriRepresentation()](https://developer.apple.com/documentation/coredata/nsmanagedobjectid/urirepresentation()) — archiveable URI; temporary IDs change on save.
- [isTemporaryID](https://developer.apple.com/documentation/coredata/nsmanagedobjectid/istemporaryid)
- [managedObjectID(forURIRepresentation:)](https://developer.apple.com/documentation/coredata/nspersistentstorecoordinator/managedobjectid(forurirepresentation:))
- [existingObject(with:)](https://developer.apple.com/documentation/coredata/nsmanagedobjectcontext/existingobject(with:))
- [Using Core Data in the background](https://developer.apple.com/documentation/coredata/using_core_data_in_the_background) — pass IDs, not objects, across queues.
