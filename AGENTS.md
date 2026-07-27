# univer — notes for AI agents

**Public** Engineering Builder **v2** · org [vil4engineering](https://github.com/vil4engineering) · site [vil4engineering.github.io/univer](https://vil4engineering.github.io/univer/) · repo `vil4engineering/univer`

## Identity gate (mandatory)

Before any repo-changing work (edit / create / delete / move / commit / push / IA / nav), if the human speaker is **not yet known** in this chat:

1. Ask once, clearly: **«Ты Максим или Тимур?»**
2. Do **not** assume Maxim.
3. Do **not** apply Owner/architecture powers until answered.
4. After the answer, follow the matching role below for the rest of the session (re-ask only if a new person clearly takes over).

Human-facing summary: [`campus/HOW_TO_ADD_WITH_AI.md`](campus/HOW_TO_ADD_WITH_AI.md) · product Home [`README.md`](README.md).

---

## Human roles

### Maxim (Owner)

Father · product owner · architecture authority.

| May | Must not (without explicit Owner intent) |
|-----|------------------------------------------|
| Change IA, `_sidebar.md`, product model, `.ai/`, `.author/`, constitution/principles | Invent private career facts into this repo |
| Design → Approve → Write chapters; ratify structure | Skip Reviewer when claiming chapter Accept |
| Full content + architecture + tooling | Auto-commit / auto-push without being asked |
| Intake triage, faculty depth (esp. Mobile/iOS) | |

Voice of Learning pages stays **ты** to Timur even when Maxim authors.

### Timur (Learner + content contributor)

Son · primary reader · may **add materials**, must **not break architecture**.

| May (agent helps) | Forbidden for Timur mode — agent must refuse and suggest Maxim |
|-------------------|----------------------------------------------------------------|
| Add / extend **Glossary** rows (A–Z + Domain + short why) | Change `_sidebar.md`, Home chrome structure, faculty list/order |
| Add chapter / lab **content** into **existing** shelves (faculties, fundamentals, swift, labs) following chapter-shape | Edit `campus/IA_*.md`, `DISPLAY_*.md`, `.ai/constitution*`, principles that define the system |
| Propose a new topic / term; draft text under existing paths | Mass-move, rename product, retire/restore Path chrome, rewire Docsify |
| Ask explanations, next-step study help | Delete architecture / Author portal / governance |
| Follow [`campus/HOW_TO_ADD_WITH_AI.md`](campus/HOW_TO_ADD_WITH_AI.md) prompt | Change this `AGENTS.md` identity/architecture policy |

**Hard rule:** if Timur asks for something that alters **architecture, navigation, IA, or governance**, do **not** do it. Explain briefly and say Maxim must approve. Content additions that fit existing shelves are OK.

When unsure whether a request is “content” vs “architecture” → treat as architecture → ask Maxim (or refuse in Timur mode).

---

## Read first (order)

1. **Identity gate** (above) — then Maxim or Timur matrix  
2. [`.ai/README.md`](.ai/README.md) — constitution · collaboration · AI roles  
3. **Creator Portal (authors — not Learn site):** [`.author/README.md`](.author/README.md)  
   Platform SoTs:  
   - [teaching-model](.ai/principles/teaching-model.md)  
   - [review-criteria](.ai/principles/review-criteria.md)  
   - [content-lifecycle](.ai/principles/content-lifecycle.md)  
4. **New chapter playbook:** [`.ai/workflows/chapter-fill.md`](.ai/workflows/chapter-fill.md)  
5. Human coach (students): [`campus/ASSISTANT_MANUAL.md`](campus/ASSISTANT_MANUAL.md)  
6. Study spine: [`campus/ROADMAP_SENIOR.md`](campus/ROADMAP_SENIOR.md) · Mode A [`campus/OPERATING_MODES.md`](campus/OPERATING_MODES.md)

**IA:** [campus/IA_1.0.md](campus/IA_1.0.md) — Layer 1 Learn ≠ Layer 2/3 Engine. Do not put Author SDK on public Home/sidebar.

**Private career:** [vil4max/career](https://github.com/vil4max/career) — never absorb private facts here.

**Intake (Saved triage workspace):** [`intake/`](intake/) · living rules [`intake/RULES.md`](intake/RULES.md) · dumps [`intake/captures/`](intake/captures/) · workflow [`.ai/workflows/tg-saved-triage.md`](.ai/workflows/tg-saved-triage.md). Not Library. Not sidebar. Shelve later → delete capture. **Timur mode:** do not run intake architecture; Maxim only.

## Human commands

Trigger phrases (any close variant counts — including RU-layout typos like `штищч` → `inbox`):

| Human says (examples) | Agent does |
|-----------------------|------------|
| `/saved` · `inbox` · `штищч` · «переберём инбокс в тг» · «перебери Saved» · «TG inbox» · «inbox zero Saved» | **Maxim only.** Open [`.ai/workflows/tg-saved-triage.md`](.ai/workflows/tg-saved-triage.md) + [`intake/RULES.md`](intake/RULES.md). Triage Saved **one item at a time** (analyze → options → wait → act). Do not auto-start on every chat. |
| `/audit` · `monthly audit` · «месячный аудит» · «прогони monthly audit» · «аудит базы» | **Maxim only.** Open [`.ai/workflows/monthly-audit.md`](.ai/workflows/monthly-audit.md). Reviewer only — report, do not rewrite. Log run under [`reviews/audits/`](reviews/audits/). |

## Learning vs authoring

| Mode | Entry | Who |
|------|--------|-----|
| Student foundations | Foundations · Execution Spine · ch.0 | Timur reads; Maxim owns spine |
| Add glossary / shelf content | HOW_TO_ADD_WITH_AI · chapter-shape | Timur **or** Maxim |
| Author a full chapter (Design gate) | [`.author/`](.author/) · `chapter-fill` | **Maxim** (Timur may draft text only into existing slot) |
| Tiny fix on existing page | [`.ai/workflows/improve-topic.md`](.ai/workflows/improve-topic.md) | Both for prose; Maxim for structure |
| TG Saved inbox-zero | [`.ai/workflows/tg-saved-triage.md`](.ai/workflows/tg-saved-triage.md) | **Maxim** |
| Monthly / off-cycle base audit | [`.ai/workflows/monthly-audit.md`](.ai/workflows/monthly-audit.md) | **Maxim** (Reviewer only) |
| Architecture / IA / sidebar | IA_1.0 · DISPLAY | **Maxim only** |

## Conventions

- SE center; Mobile Systems = depth faculty; AI = assisted + technology  
- Campus-first; Library = warehouse; no mass-move without Design (Maxim)  
- RU-primary + EN terms ([`campus/LANGUAGE.md`](campus/LANGUAGE.md) · [`.ai/principles/language.md`](.ai/principles/language.md))  
- Ideas over tech catalogs ([content-philosophy](.ai/principles/content-philosophy.md))  
- **Platform trio:** [teaching-model](.ai/principles/teaching-model.md) · [review-criteria](.ai/principles/review-criteria.md) · [content-lifecycle](.ai/principles/content-lifecycle.md)  
- Chapter shape → Topic template chrome  
- Evidence on Path logs; no invented experience; commit/push only when asked  
- Org slug rules: `vil4engineering` · curriculum repo `univer`

## Catalog tooling

```bash
python3 scripts/check_library_sync.py
python3 scripts/write_library_map.py
```

## Cursor Cloud specific instructions

The product is a **Docsify** static site (RU-primary curriculum). There is no build step and no package manager: markdown is rendered client-side, and Docsify + its plugins load from the **jsDelivr CDN**, so rendering requires network egress to `cdn.jsdelivr.net`. The Python catalog tooling under `scripts/` uses only the standard library — nothing to `pip install`.

**Run the site locally (non-obvious):** the committed `index.html` sets `basePath: '/univer/'`. Serving the repo root directly at a server root therefore shows a blank page (markdown requests 404 under `/univer/`). Serve so the repo is reachable under a `/univer/` path, e.g.:

```bash
mkdir -p /tmp/docsify-root && ln -sfn "$PWD" /tmp/docsify-root/univer
python3 -m http.server 3000 --directory /tmp/docsify-root
# open http://localhost:3000/univer/
```

`docsify serve` (docsify-cli) is the upstream dev tool but is not required and global npm install may fail on permissions; the stdlib server above is sufficient and gives the same client-side routing/search.

**Tooling gotchas:** `scripts/check_library_sync.py` currently reports `FAILED` on `main` (pre-existing disk/`TOPIC_TREE` drift, e.g. `ai-engineering/materials`, `swift/what-is-swift`) — not caused by env setup. `scripts/resources_index.py` and `scripts/write_library_map.py` **regenerate tracked files** (`reference/curated/README.md`, `campus/library/README.md`) when run, so `git checkout --` them if you only meant to check, not to commit. Fixing content/IA/`TOPIC_TREE` is Owner-gated (see identity gate above).
