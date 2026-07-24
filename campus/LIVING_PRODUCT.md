# Living Product (Core World)

**Status:** Design intent — product pick still **intentionally undecided** ([PROJECT_STATUS.md](../PROJECT_STATUS.md)).  
**Related:** [DESIGN_CAPTURE_LIVING_UNIVERSITY.md](DESIGN_CAPTURE_LIVING_UNIVERSITY.md) · [CODE_CONTRACT.md](CODE_CONTRACT.md) · [REFERENCE_WORLDS.md](REFERENCE_WORLDS.md) · [projects-map.md](projects-map.md)

## Why this file exists

Labs must not become a demo zoo. When we choose a Living Application, it must be a **product students want to open**, with educational value as a consequence — not the other way around.

## Spaces

```text
Core World          ← installable app; coherent domain; production-style bar (L3)
    ↑ modules
Learning modules    ← features that teach while improving the product (L2)
Sandbox / Evolution ← may sit outside the app target; experiments + API history (L1)
```

Bars: [CODE_CONTRACT.md](CODE_CONTRACT.md).

## Binding rules (even before pick)

1. **Product before API demo.** A technology enters Core because it improves something the user cares about (load real data, show stats, sync, search…).  
2. **One world, recurring heroes.** Prefer Reference World entities over `Foo`/`Bar`.  
3. **Evolution outside runtime is OK.** “Button then / Button now” files need not ship in the app binary.  
4. **Every topic leaves a trace.** If studying a topic did not change Sandbox, Lab, or Core — study is incomplete.  
5. **Quality tiers differ.** Dirty Sandbox OK; dirty Core not OK.  
6. **Git is curriculum.** Issues, branches, PRs, review — part of the university, not only VCS.  
7. **Ideas may flow to PitStop.** University is R&D; PitStop stays a separate product.  
8. **macOS / multiplatform later.** Architecture may allow it; do not force a second platform before Core exists.

## Candidates (not chosen)

| Candidate | Notes |
|-----------|--------|
| Football Companion / Universe app | Strong for Student B; risk if football-only — mitigate with Automotive / Banking packs |
| AI Workspace (`projects/ai-lab-ios`) | Strong AI Track 2 lab; may stay specialized lab, not the only Core |
| University site / Career OS | Charter listed; Career OS private facts stay outside public Core |
| Groundhog / netsession | Teaching apps / labs — integrate by role, not nostalgia |

Pick in a dedicated Design session. Until then: stage labs in `projects/`, cite from Paths, do not invent a third “demo app” repo.

## Definition of ready (when picked)

- Builds and runs on a phone / Simulator  
- Has a story (people, domain objects, screens that matter)  
- Can accept Learning modules without becoming a dump  
- Sandbox does not break Core CI  
- Mapped to faculties / topics via lab ids  

## Anti-goals

- Football catalog with no engineering story  
- Fifty mini-apps named `*Demo`  
- Production architecture theater with nothing to learn  
- Requiring Objective-C mastery to understand modern Swift samples  
