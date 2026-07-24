# Language

**Binding for Engineering University v0.1+.** Aligns with [01_CHARTER.md](../01_CHARTER.md) § Languages.  
Agent principle (same policy): [../.ai/principles/language.md](../.ai/principles/language.md).

## Policy

| Layer | Language |
|-------|----------|
| Explanations, mental models, campus prose | **Russian** (RU-primary) |
| Address the reader | **ты** — пишем сыну, не «аудитории курса» |
| Terms, API names, identifiers, Apple/WWDC vocabulary | **English as-is** (`Task`, `Actor`, `ARC`, `Sendable` — not calques) |
| Interview English | Optional dedicated blocks for spoken answers — not a full page twin |

**Russian** is the explanation language. **English** is the engineering language.  
**Voice:** warm, direct, second person singular (`ты` / imperative `научись`, `открой`) — not formal `вы` and not marketing plural.

Readers should become comfortable with Apple Documentation, Swift Evolution, WWDC, papers, RFCs, and technical books — without artificial RU translations of standard terms.

## Not this university

- Dual EN+RU mirrored pages / `<details class="lang-ru">` bilingual format
- EN-only encyclopedia as the product voice
- Translating every technical term into Russian

## Warehouse debt

Legacy Library READMEs are often English-first. That is **inventory debt**, not the target.

- New campus / path / faculty pages: RU-primary + EN terms from day one
- Library topics: rewrite toward RU-primary when touched on a Path (progressive), not a bulk translate in Order phase

## Tooling

Bilingual / EN-only linters and migrate scripts are removed. Do not reintroduce them.
