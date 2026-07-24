# Collaboration

Who may change Engineering Builder, and how.

The repository remains the center. AI tools are specialized participants with clear zones. New models can join later without changing the philosophy.

---

## Human speakers (before AI roles)

Root [`AGENTS.md`](../AGENTS.md) **Identity gate** is mandatory: ask **Maxim or Timur** before repo-changing work.

| Human | Power |
|-------|--------|
| **Maxim** | Owner — strategy, IA, nav, `.ai/`, Approve, full edits |
| **Timur** | Learner + content — may add Glossary/chapters/labs on **existing** shelves; **must not** change architecture/nav/governance |

Agents refuse architecture changes in Timur mode. Details and allowlists live only in `AGENTS.md` (do not fork a second matrix here).

---

## Participants

```text
Owner (Maxim)
  ↓
Defines strategy and makes final decisions.


Cursor
  ↓
Repository editor and maintenance engineer.
Structure, file ops, refactors, search, link hygiene, bulk consistency, catalog tooling.

ChatGPT (and deep chat models: Claude, etc.)
  ↓
Engineering consultant and educational architect.
Technical accuracy, explanation depth, curriculum routes, interview depth, labs design,
trade-off analysis, historical context, knowledge-system design.

Codex / other coding agents
  ↓
Same constitution. Prefer Cursor-like duties (structure, edits) or Author under Reviewer+Architect gate.
Never invent a second Source of Truth.

Engineering Builder (this repository)
  ↓
Single Source of Truth.
No participant creates parallel versions of knowledge.
Every change improves the existing system.
```

---

## Responsibility matrix

| Concern | Owner (Maxim) | Cursor | ChatGPT-class | Any agent |
|---------|---------------|--------|---------------|-----------|
| Strategy / ratification | decide | advise | advise | — |
| Architecture / IA / sidebar | **decide** | apply only if Maxim | propose | refuse in Timur mode |
| File create / move / bulk edit | approve | **do** (Maxim); content-only if Timur | propose text | follow human role |
| Deep explanation / trade-offs | approve | draft if asked | **prefer** | Author role |
| Graph / merge / SoT | approve | apply | Architect analysis | Architect role; Timur → refuse graph moves |
| Path lesson / Evidence write-back | accountable | **coach** (`campus/`) | support | no fake Evidence |
| Commit / push | ask explicitly | only when asked | never assume | never assume |
| Private career facts | keep private | exclude | exclude | exclude |
| Glossary / shelf content add | yes | yes | draft | Timur **may**; Maxim may |

---

## Tool strengths (divide, do not compete)

### Prefer Cursor for

- Writing and editing files in the tree
- Refactors and renames
- Repository search and orphan detection
- Generating structure and scaffolding
- Updating cross-links at scale
- Running `scripts/check_library_sync.py` and related hygiene

### Prefer ChatGPT-class for

- Explaining hard concepts from first principles
- Finding weak spots in explanations
- Building learning routes (Curriculum Designer)
- Deep interview questioning (Interviewer)
- Trade-off and decision analysis
- Historical / “why this exists” context
- System design depth and production scenarios

### Working pattern

1. Architect or Owner decides *where* knowledge lives.
2. ChatGPT-class deepens *what* should be understood.
3. Cursor applies *how* it lands in the repo (shape, links, template).
4. Reviewer + Mentor check quality and learnability.
5. Owner ratifies when strategy is affected.

---

## Role switching

One active governance role per task (see [roles/](roles/)).

Do not be Author and Reviewer in the same pass on your own draft. Prefer a clean handoff: Author → dual-pass Reviewer ([workflows/dual-pass-review.md](workflows/dual-pass-review.md)) → Architect (if structure changed).

**Accept** only after an explicit Reviewer pass (separate message or model). Prefer a different model when available.

Playbooks: [workflows/improve-topic.md](workflows/improve-topic.md) · [workflows/interview-prep-session.md](workflows/interview-prep-session.md).

---

## Conflict rule

If tools disagree:

1. Constitution wins.
2. Source of Truth / Architect graph rules win over prose polish.
3. Owner decides.

---

## Related

- [constitution.md](constitution.md)
- [README.md](README.md)
- [workflows/](workflows/)
- `campus/ASSISTANT_MANUAL.md` — human learning coach (Cursor Path ritual)
- root `AGENTS.md` — thin committed agent entrypoint → `.ai/`
