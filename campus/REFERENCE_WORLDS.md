# Reference Worlds

Shared living domains for examples — not separate demo apps forever.

Principle: **programming models the real world**. Prefer emotional, consistent entities over `Foo`/`Bar`.

## Worlds

| World | Use | Notes |
|-------|-----|--------|
| Football Universe | Collections, graphs, concurrency of a match, networking “load squad”, physics/math *doors*, AI for game-like decisions | Not “a FIFA course” — a life domain students care about |
| Automotive | PitStop-inspired cars, maintenance, trips, maps | PitStop product stays independent; world may share ideas |
| Mobile / App | Screens, StoreKit-like ideas, notifications | Meta world of the phone itself |
| Banking / Commerce | Optional later | Payments, ledgers as teaching domains |
| Games / engines | Optional | Pathfinding, physics doors for Student B |

Pick **one primary Core World** when Living Product is chosen. Others remain example packs.

## Cross-cutting entities (“heroes”)

Entities should recur across topics: `Person`, `Player`, `Club`, `Contract`, `Car`, `Match`, …

Same hero explains OOP vs composition, collections, actors, persistence, UI.

## For Student B

Examples from football, cars, and games beat abstract `User`.  
School subjects (math, physics, geometry) appear as **doors** (“why the ball flies”) — directions to go deeper, not homework formula dumps.

## Guardrail

Entertainment serves learning. If an example does not clarify an engineering idea, cut it (Charter north-star gate).
