# Code contract

## Spaces

| Level | Where | Bar |
|-------|--------|-----|
| L1 Sandbox / Evolution / Playground | Often outside app target | Compiles (if in target) · teaches one idea · architecture optional · PR almost always OK |
| L2 Laboratory module | Extends Core World | Clean · linked to topic · tests when relevant · real review |
| L3 Production-style Core World | Main app | Full PR · tests · lint · CI · docs as needed |

Legacy/evolution samples may live **outside runtime** on purpose (Button then / Button now). That is valid Sandbox.

## PR types (suggested labels)

`experiment` · `lesson` · `research` · `wwdc` · `evolution` · `feature` · `fix` · `refactor`

Every PR answers: **What did the university learn?**

## CI

Sandbox must not break Core World. Core World stays installable on a phone when we claim “live product.”

## Educational value rule

If a file teaches nothing, demonstrates no evolution, and improves no world — delete it even if “pretty.”

Dirty Sandbox is allowed when it creates understanding. Dirty Core World is not.

## Relationship to external samples

Apple Sample Code, Point-Free, Hacking with Swift, WWDC samples: **study, adapt, cite** — do not compete or copy wholesale.

## Staged projects today

Mapped in [projects-map.md](projects-map.md). Migration rule: delete / archive / integrate by educational role — not by nostalgia.
