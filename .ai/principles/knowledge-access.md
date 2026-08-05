# Principle: Knowledge access

How knowledge is **delivered**. Orthogonal to [IA Layers](../../campus/IA_1.0.md) (Learning · Authoring · Engineering).

Never call these access planes “Layer 1 / 2 / 3”.

## Access planes

| Plane | Role | Must not |
|-------|------|----------|
| **GitHub repository** | Sole Source of Truth for public curriculum knowledge | Invent a second canon outside git |
| **Docsify / Pages** | Learn UI over the same git tree | Store or invent knowledge |
| **RAG / AI retrieval** (Design intent) | Index + retrieve over the repo | Become a second SoT; answer from weights instead of Library |

```text
Human
  → GitHub (SoT)
  → Structured knowledge
       ├─ Docsify → Student
       └─ RAG index → Cursor / Claude / ChatGPT
```

RAG **indexes**; it does not own truth. Runtime / embeddings are **not** required for this principle to bind.

### Future RAG corpus (intent)

1. Library (canonical chapters)  
2. Glossary  
3. Interview Packs  
4. Learning Sessions (why-history; secondary to chapters)

### Retrieval profiles (when an index exists)

| Profile | Use | Prefer |
|---------|-----|--------|
| **Learning** | Study a topic | Chapter · neighbors · glossary · Interview Pack · labs · projects |
| **Authoring** | Write / persist | teaching-model · chapter-shape · review-criteria · writing · glossary · neighbors · reviews · learning-session |

Do not mix Authoring kitchen into a student-facing retrieval profile.

## Write-back sinks (one meaning → one place)

| Sink | What | Retention |
|------|------|-----------|
| [`intake/`](../../intake/) | Telegram Saved raw | Delete after shelf |
| [`.author/learning-sessions/`](../../.author/learning-sessions/) | Curated prep extract | Retain; mark `superseded` when chapter moves on |
| [`.author/prep-map.md`](../../.author/prep-map.md) | Interview Prep Map (block blitz) | Retain; bump version on block close |
| Canonical topic `README` | Engineering knowledge | SoT |
| `notes/Interview-Pack.md` | 30–60s projection + follow-ups | Projection → SoT |
| [`glossary/`](../../glossary/) | Term cards | SoT |
| Path Evidence / Progress | Mode A study telemetry | Optional; not a Publish gate |

Mode A lesson exit: [../workflows/persist-learning-session.md](../workflows/persist-learning-session.md).  
Do not invent a fifth prep-log format.

Learning Sessions are **Authoring** (Creator Portal). Never Learn chrome / student sidebar.

## Related

- [source-of-truth.md](source-of-truth.md)
- [university.md](university.md)
- [../../campus/IA_1.0.md](../../campus/IA_1.0.md)
- [../../campus/OPERATING_MODES.md](../../campus/OPERATING_MODES.md)
