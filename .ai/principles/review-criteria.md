# Principle: Review criteria

**Official scoring bar for every chapter.**

**Audience:** authors and Reviewers — **not students**.  
Do not link this page from public Learn chrome (Home / student sidebar). Entry: [`.author/`](../../.author/).

This is the SoT. Chat discussions are not the bar.  
Operational checklist: [../checklists/chapter-review.md](../checklists/chapter-review.md).  
Journal: [`reviews/`](../../reviews/).  
Pedagogy: [teaching-model.md](teaching-model.md).  
Lifecycle: [content-lifecycle.md](content-lifecycle.md).

Author must not Accept their own draft ([../workflows/dual-pass-review.md](../workflows/dual-pass-review.md)).

---

## Four gates (must all pass)

| Gate | Question |
|------|----------|
| **Beginner** | Will a beginner (and a child years from now) understand? |
| **Engineer** | Is this useful in real work? |
| **Interview** | Does this help answer an interviewer? |
| **University** | Will this still matter in ~10 years? |

Fail any gate → **Request changes** or **Reject**. Do not Accept on prose polish alone.

---

## Ten criteria (/10)

Score each. **Average** = mean of scored rows.

| # | Criterion | What “10” means |
|---|-----------|-----------------|
| 1 | **Main idea** | One clear engineering idea; mental-model shift, not “nice text” |
| 2 | **Narrative** | Natural flow: problem → history → idea → solution → practice |
| 3 | **Technical accuracy** | Facts correct; speculation labeled; no false API claims |
| 4 | **Mental model shift** | Explicit before → after; reflection earns it |
| 5 | **Production relevance** | Idea connects to real systems / failure / constraints (Swift/platform as illustration) |
| 6 | **Interview value** | Can project honest Q / follow-ups / common mistakes |
| 7 | **Exercises** | Practice forces the model to move (not busywork) |
| 8 | **Cross-links** | Graph: prerequisites, next, Part/module anchors — no orphan essay |
| 9 | **Longevity** | Idea-level spine survives API / framework churn |
| 10 | **Diagrams / visuals** | Each diagram answers “what is clearer now?” — else cut |

Legacy RU labels (same bar): главная идея · логика · история · глубина · диаграммы · практика · production · interview · beginner · долговечность — map into the table above when writing `reviews/`.

### Bands

| Band | Meaning |
|------|---------|
| 9–10 | Textbook chapter |
| 7–8 | Ship after small fixes |
| 5–6 | Major spine rewrite |
| <5 | Reject / redesign |

---

## Chapter-as-product checks (Reviewer glance)

| Artifact | Present? |
|----------|----------|
| Architecture intent (why / spine) | in DESIGN or teaching alignment |
| Contract | `DESIGN.md` |
| Implementation | `README.md` (Reader Header) |
| Interview projection | `notes/Interview-Pack.md` or section |
| Review history | `reviews/NNNN-…` |
| Version | Engineering Metadata |
| Roadmap / Next | Part map or Next section |

Missing contract on a flagship chapter → **Major** at least.

---

## Verdict vocabulary

| Verdict | When |
|---------|------|
| **Accept** | Four gates pass; no open Major; average usually ≥ 8 or Owner override documented |
| **Request changes** | Fixable Majors / failed gate |
| **Reject** | Wrong question, dictionary spine, or unfixable without redesign |

---

## External reviewers

Prefer **GitHub blob / raw** links. Docsify `#/` SPA is not a reliable review surface.

---

## Related

- [../checklists/chapter-review.md](../checklists/chapter-review.md)
- [../checklists/topic.md](../checklists/topic.md)
- [../checklists/chapter-design.md](../checklists/chapter-design.md)
- [teaching-model.md](teaching-model.md)
- [content-lifecycle.md](content-lifecycle.md)
- [content-philosophy.md](content-philosophy.md)
