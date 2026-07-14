# Lab registry

Experiments inside the university (“what happens if…?”), not orphan tutorials.

Status: **index of existing artifacts**. Physical paths unchanged.

## A. Staged project labs (`projects/`)

| Lab id | Path | Xcode / SPM | Linked topics |
|--------|------|-------------|---------------|
| `lab-netsession` | [projects/netsession-lab](../../projects/netsession-lab/) | `Package.swift` | Networking |
| `lab-ai-workspace` | [projects/ai-lab-ios](../../projects/ai-lab-ios/) | XcodeGen `project.yml` | AI track |
| `lab-unit-tests` | [projects/unit-tests-lab](../../projects/unit-tests-lab/) | docs → testing notes | Testing |
| `lab-groundhog` | [projects/groundhog-day-ios](../../projects/groundhog-day-ios/) | `ios/*.xcodeproj` | Small app / product craft |
| `lab-flip-english` | [projects/flip-english](../../projects/flip-english/) | docs | FM / SRS case |

Details: [projects-map.md](../projects-map.md).

## B. Playground labs (Library co-located)

| Area | Examples (open in Xcode) |
|------|---------------------------|
| Concurrency | `swift/concurrency/*.playground` |
| Architecture | `architecture/**/*.playground` |
| Networking / storage | `data-and-network/**/*.playground` |
| Swift syntax / ARC | `swift/syntax`, `swift/memory-arc` |
| Algorithms | `algorithms/structures/Jeff*.playground`, CodeKata |
| Testing | `quality/testing/testing.playground` |
| AI | `ai-engineering/mcp/ai_tooling_mcp.playground` |
| System design | `system-design/mobile`, `feature-flags` playgrounds |

Full filesystem list grows over time; add **lab id** rows here when a playground becomes a first-class experiment.

## Completeness

A lab graduates when it has: question · procedure · measurement/observation · reflection link on a topic page.
