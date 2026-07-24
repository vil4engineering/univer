# Content reviews (journal)

Analog of **code review** for chapters: durable decisions, evolution, context for future AI/human authors.

Not curriculum. Not a second copy of the chapter.

## Layout

```text
reviews/
  README.md
  _TEMPLATE.md
  0001-what-is-programming.md
  0002-….md
```

Number = review order (not chapter order). One file per **review pass** (or amend the same file’s Decision log if Owner prefers a single living review).

## When to write

After Phase B (`README.md` written), Reviewer fills `reviews/NNNN-slug.md` using [`.ai/checklists/chapter-review.md`](../.ai/checklists/chapter-review.md).

External tools that cannot open Docsify SPA: use **GitHub blob / raw** links listed in each review header.

## Do not

- Rewrite the chapter inside the review (findings only; Author fixes separately)
- Store private career facts
- Accept without Four gates + ten criteria scored
