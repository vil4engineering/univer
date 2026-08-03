# Linking model

How campus pieces connect — **before** automation exists.

```text
Competency / Topic (onion page)
    │
    ├── related topics (graph links)
    ├── origin / references
    ├── Lab id ──────────────► labs/README registry
    │                              │
    │                              ├── Git path (playground or projects/…)
    │                              └── Xcode scheme / SPM target / .swiftpm
    ├── Evidence (tests, Instruments notes, reflection)
    └── Assessment / Portfolio entry (future)
```

## Rules

1. **Do not rely on folder path alone** as identity — prefer topic id + lab id in registries.
2. Library folders are storage. Campus indexes are navigation.
3. Staged `projects/*` stay where they are until a Living App decision; they already appear in [projects-map.md](projects-map.md).
4. Cross-links in markdown use relative Docsify paths.
5. A topic without a lab may still be Surface/Why incomplete — mark Completeness honestly.

## GitHub / shareable library links

| Role | Value |
|------|--------|
| Public product org (naming / Pages) | `vil4labs` |
| Pages (share with a reader) | `https://vil4labs.github.io/univer/` |
| This machine’s `origin` | `https://github.com/vil4labs/univer.git` — still verify `git remote -v` before push |
| Curriculum repo name | `univer` |

**Docsify deep link** (browser or agent):

```text
https://vil4labs.github.io/univer/#/<path>/
```

Examples:

- Hub: `https://vil4labs.github.io/univer/#/swift/concurrency/`
- Chapter: `https://vil4labs.github.io/univer/#/swift/concurrency/sendable-and-strict-concurrency/`
- Spine гл.1: `https://vil4labs.github.io/univer/#/fundamentals/literal-executor/`

Local: serve under `/univer/` (see root `AGENTS.md`) then `http://localhost:3000/univer/#/<path>/`.

Campus URLs: `/campus/…` · Library URLs: `/swift/…`, `/fundamentals/…`, …
## Xcode / SPM (today)

| Artifact | Open with | Notes |
|----------|-----------|--------|
| `*.playground` | Xcode | Co-located under Library topics |
| `projects/netsession-lab` | `Package.swift` / Xcode | Networking lab |
| `projects/ai-lab-ios` | `project.yml` → XcodeGen | AI workspace candidate |
| `projects/groundhog-day-ios/ios` | `.xcodeproj` | Small teaching app |
| `projects/unit-tests-lab` | docs only for now | Points at testing library notes |
| `projects/flip-english` | docs | Product/FM case notes |
