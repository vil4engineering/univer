# Checklist: Chapter content review

Use **after** Phase B write and **before** Accept. Complements [topic.md](topic.md) (SoT / template) with a **pedagogy bar**.

Save a durable copy under repo root [`reviews/`](../../reviews/) — see [reviews/README.md](../../reviews/README.md).

Source for external reviewers (SPA does not index): GitHub blob or raw `.md`, not only GitHub Pages `#/` URLs.

---

## Four gates (must all pass)

| Gate | Question | Pass? |
|------|----------|-------|
| Beginner | Поймёт ли новичок (и сын через годы)? | |
| Engineer | Полезно ли в реальной работе? | |
| Interview | Поможет ли ответить интервьюеру? | |
| University | Останется ли актуальным через ~10 лет? | |

**Rule:** fail any gate → **Request changes** (or Reject). Do not Accept on style alone.

---

## Ten criteria (/10)

| # | Criterion | /10 | Notes |
|---|-----------|-----|-------|
| 1 | Главная идея (mental-model shift, not “good prose”) | | |
| 2 | Логика повествования (Problem → History → Idea → Solution → Practice) | | |
| 3 | Исторический контекст (why this idea existed) | | |
| 4 | Глубина объяснения (без перегруза «учат вместо вывода») | | |
| 5 | Диаграммы (каждая отвечает: что стало понятнее?) | | |
| 6 | Практические примеры | | |
| 7 | Production perspective (идея → инженерия → Swift / platform) | | |
| 8 | Interview value | | |
| 9 | Beginner friendliness | | |
| 10 | Долговечность (idea-level; survives API churn) | | |

**Average** = mean of scored rows. Optional band:

| Band | Meaning |
|------|---------|
| 9–10 | Textbook chapter |
| 7–8 | Ship after small fixes |
| 5–6 | Major rewrite of spine |
| <5 | Reject / redesign |

---

## Qualitative blocks (required in `reviews/NNNN-….md`)

1. **Сильные стороны**
2. **Что убрать**
3. **Что переписать**
4. **Что добавить**
5. **Связать с главами** (graph)
6. **Диаграммы** — по каждой: вопрос «что понятнее?» или cut
7. **Verdict:** Accept | Request changes | Reject
8. **Owner decision** (fill after human read)

---

## Related

- [topic.md](topic.md) — structural Accept gate
- [chapter-design.md](chapter-design.md) — Phase A only
- [../workflows/chapter-fill.md](../workflows/chapter-fill.md)
- [../workflows/dual-pass-review.md](../workflows/dual-pass-review.md)
- [../principles/content-philosophy.md](../principles/content-philosophy.md)
