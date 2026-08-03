# Principle: Content lifecycle

**SDLC for university content** — how a chapter moves from idea to a **linkable library page** (and optional later study notes).

This turns the repo from a document dump into an **engineering product** with a repeatable release process.

Pedagogy: [teaching-model.md](teaching-model.md).  
Quality bar: [review-criteria.md](review-criteria.md).  
Day-to-day playbook: [../workflows/chapter-fill.md](../workflows/chapter-fill.md).

---

## Chapter = product

Do not treat a chapter as “a markdown file.”

Treat it as a **product** with the same seriousness as a software subsystem.

| Product concern | Chapter artifact |
|-----------------|------------------|
| Architecture / intent | Fundamental why · spine · [teaching-model.md](teaching-model.md) |
| Contract | `DESIGN.md` |
| Implementation | `README.md` (Student Mode Reader Header) |
| API for interviews | `notes/Interview-Pack.md` (projection) |
| Review history | `reviews/NNNN-….md` |
| Version | Engineering Metadata (`v1`, `v1.1`, …) |
| Roadmap | Part map · Next (hub Reading route) |
| Telemetry / learning | Optional reader self-check · Confidence — **not** a Publish gate |

Authors ship products. Reviewers gate releases. Owner accepts risk.

---

## Pipeline

```text
Idea
  → Design
  → Design Review
  → Owner Approve
  → Draft (write)
  → Engineering Review (dual-pass)  [or Owner Formal Accept for theory — journal required]
  → Revision
  → Publish  ← library Done: shareable Pages link
  → Optional study notes / labs (any reader, any time)
```

| Stage | What happens | Exit gate |
|-------|--------------|-----------|
| **Idea** | Why-question + module slot (e.g. Execution Spine / n). External raw dumps may land in [`intake/`](../../intake/) first | Architect if new path / duplicate; intake is staging only — shelve or delete, never leave forever |
| **Design** | `DESIGN.md` only — page architecture, not full prose | [chapter-design](../checklists/chapter-design.md) |
| **Design Review** | Owner + Reviewer stress-test structure | Issues logged on DESIGN |
| **Owner Approve** | Explicit «пиши главу» / approve design | Required — no skip |
| **Draft** | Author writes `README.md` (+ Interview-Pack) from DESIGN | Follow [write-chapter](../prompts/write-chapter.md) |
| **Engineering Review** | Dual-pass Reviewer; score [review-criteria](review-criteria.md); file `reviews/` | Accept / Request changes / Reject |
| **Revision** | Author fixes; new review pass if needed | Majors closed |
| **Publish** | Merge to default branch · Pages | **Shareable library page** |
| **Optional study** | Reader opens link / lab when they can | Never blocks Publish; agents must not invent completed Evidence |

**Forbidden:** Draft without Design Review + Owner Approve.  
**Forbidden:** Author self-Accept.  
**Forbidden:** Mass-create empty chapter folders “for later.”  
**Forbidden:** Treat a named student or Path log as a fill / Publish gate.  
**Forbidden:** Auto-start the «next» topic without Owner naming path + why.

---

## Roles (short)

| Role | Owns |
|------|------|
| Architect | Graph, duplicates, Part placement |
| Author | DESIGN → Draft → Revision |
| Reviewer | Design Review + Engineering Review |
| Owner | Approve design · Accept risk · override documented |
| Mentor / Student | May study after Publish — optional; not an agent checklist |

Detail: [../collaboration.md](../collaboration.md) · [../roles/](../roles/).

---

## Versioning

| Version | Meaning |
|---------|---------|
| `stub` | Path exists; body not serious yet |
| `v1` | First full draft after Approve |
| `v1.1` | Pedagogy / structure revision (same contract) |
| `v2` | New Design Review (contract changed) |

Bump in Engineering Metadata + review note. Do not silently rewrite Accept chapters without a review pass.

---

## Publish surfaces

| Audience | Surface |
|----------|---------|
| Student | GitHub Pages · Reader Header · Learning `<details>` |
| Author / Reviewer | `DESIGN.md` · `reviews/` · Engineering `<details>` · blob/raw |

[DISPLAY_0.1.md](../../campus/DISPLAY_0.1.md) — Student Mode vs Author Mode.

---

## After Publish

Lifecycle **ships** at merge/Pages: the chapter is a library entry you can link.

Optional later (any reader, any time — not Owner/agent fill work):

1. Open the Pages (or local Docsify) URL · read · try linked lab  
2. Optional improve via [../workflows/improve-topic.md](../workflows/improve-topic.md)  
3. If the **question** changes → new Design (v2), not a quiet edit  

Do **not** invent study progress. Do **not** hold the next chapter hostage to unchecked Evidence boxes.

---

## Related

- [../workflows/chapter-fill.md](../workflows/chapter-fill.md)
- [../workflows/dual-pass-review.md](../workflows/dual-pass-review.md)
- [teaching-model.md](teaching-model.md)
- [review-criteria.md](review-criteria.md)
- [`../../reviews/README.md`](../../reviews/README.md)
- [`../../fundamentals/PART_I.md`](../../fundamentals/PART_I.md)
