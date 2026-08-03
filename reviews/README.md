# Content reviews (journal)

Analog of **code review** for chapters-as-products.

**Score bar SoT:** [`.ai/principles/review-criteria.md`](../.ai/principles/review-criteria.md).  
**Lifecycle:** [`.ai/principles/content-lifecycle.md`](../.ai/principles/content-lifecycle.md).  
**Pedagogy:** [`.ai/principles/teaching-model.md`](../.ai/principles/teaching-model.md).

## Layout

```text
reviews/
  README.md
  _TEMPLATE.md
  0001-what-is-programming.md
  0001b-what-is-programming.md
  0002-concurrency-theory-chain.md
  audits/                     ← monthly repo-wide audits
    YYYY-MM-monthly-audit.md
  …
```

## When to write

After Draft in the content lifecycle: Reviewer fills `reviews/NNNN-slug.md` using review-criteria (paste via [chapter-review checklist](../.ai/checklists/chapter-review.md)).

**Monthly / off-cycle base audit:** [`.ai/workflows/monthly-audit.md`](../.ai/workflows/monthly-audit.md) → journal under [`audits/`](audits/).

External tools: **GitHub blob / raw**, not only Docsify `#/`.

## Do not

- Rewrite the chapter inside the review  
- Store private career facts  
- Accept without Four gates + ten criteria (or Owner override)  
- Patch findings in the same pass as a monthly audit (report only)
