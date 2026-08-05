# Workflow: Persist learning session

Turn a curated prep session into Library knowledge. University is born during prep — not in a separate “fill warehouse later” track.

**Access / sinks:** [../principles/knowledge-access.md](../principles/knowledge-access.md)  
**Prompt:** [../prompts/persist-learning-session.md](../prompts/persist-learning-session.md)  
**Sessions home:** [../../.author/learning-sessions/](../../.author/learning-sessions/)

## Trigger

```text
Run persist-learning-session for today's interview session.
```

Owner supplies a **Session payload** (or points at a learning-session file). Prompt is **input, not law**.

## Critical intake (mandatory before writes)

1. Read constitution · teaching-model · chapter-shape · language · HOW_TO_ADD · knowledge-access  
2. Parse payload / session file  
3. Search repo for canonical homes  
4. Diff vs SoT: **accept** / **adapt** / **reject** / **ask Owner**  
5. Only then write the resolved plan  

Reject: new parallel essay trees, “today notes”, mass empty future chapters, Learn chrome for Authoring docs.

## Parallel fill

Several tracks may be open at once. One persist run scopes to **this** payload (+ minimal contradiction fixes on linked pages). Additive glossary merge. Do not wipe another track.

## Close gate vs pulse

| Kind | DoD |
|------|-----|
| **Topic close** (Owner) | All **5 artifacts** below |
| **Block close** (Owner) | Also update [Prep Map](../../.author/prep-map.md): chain · key thoughts · understanding line · interview phrase · canonical links |
| **Pulse** | Session file ± 1–2 surfaces — not forced full pack |

### Five artifacts (topic close)

| # | Artifact | Where |
|---|----------|-------|
| 1 | Interview Pack (30–60s) | `topic/notes/Interview-Pack.md` |
| 2 | Engineering Notes | Canonical `topic/README.md` (chapter-shape; improve, don’t wipe) |
| 3 | Glossary | `glossary/README.md` — A–Z + Domain + short why |
| 4 | Follow-ups | Section in the same Interview-Pack |
| 5 | Gaps | Open questions / checklist on the topic |

One concept → one canonical why-page. Prefer improve. New page only if Owner named path + why and no home exists.

Prep Map is **not** a sixth Library artifact — it is Mode A blitz telemetry (Creator Portal only).

## Steps

```text
1. Contracts + Critical intake
2. Resolve canonical why-page
3. Scope lock (this session + shared surfaces only)
4. Write/update learning-session file (curated extract)
5. Improve README (Engineering Notes spine)
6. Glossary additive merge; disambiguate if needed
7. Interview-Pack + Follow-ups + mistakes + senior notes
8. Gaps + link-only future chain
9. Cross-links to existing nodes; hub = index pointers only
10. On block close: update .author/prep-map.md (chain · thoughts · 2 lines · links)
11. Report (below) — no auto-commit / no auto-Accept / no dual-pass Accept inside this workflow
```

“Delete duplicates” = merge into survivor + stub link.  
“Generate review” = note inconsistencies; Owner runs dual-pass separately.

## Report shape

1. **Intake reconciliation** — accepted · adapted · rejected · Owner questions  
2. Track / session file  
3. Modified files + why (include prep-map if block close)  
4. Knowledge summary  
5. Cross-links  
6. Architectural inconsistencies found  

## Related

- [interview-prep-session.md](interview-prep-session.md)  
- [../../.author/prep-map.md](../../.author/prep-map.md)  
- [improve-topic.md](improve-topic.md)  
- [chapter-fill.md](chapter-fill.md)  
