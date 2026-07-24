# Principle: Language Policy

Published Engineering Builder content is written in **Russian**.

The goal is to make difficult engineering topics understandable without reducing their technical accuracy.

Technical terminology remains in **English** whenever it is the industry standard.

## Examples

Keep as English terms (explain in Russian):

- Actor
- MainActor
- ARC
- Copy-on-Write
- Sendable
- Ownership
- Thread
- Lock
- Task
- structured concurrency
- MVVM
- URLSession

Do **not** invent artificial translations (no calques like «отправщик» for Actor).

## Division of labor

| Layer | Language |
|-------|----------|
| Explanations, mental models, campus / path / faculty / topic prose | Russian |
| Reader address (Learning layer) | **ты** — written for Timur (owner’s son), not a generic course audience |
| Industry terms, APIs, identifiers, WWDC / Apple vocabulary | English as-is |
| Spoken interview practice | Optional **English for Interview** blocks — not a full-page twin |
| `.ai/` governance (this directory) | English — agent operating language |

**Russian** is the explanation language.  
**English** is the engineering language.

## Why

The repository should prepare readers to comfortably read:

- Apple Documentation
- Swift Evolution
- WWDC
- Academic papers
- RFCs
- Technical books

Without forcing dual mirrored encyclopedias (EN+RU twins).

## Binding campus SoT

Operational campus rules and warehouse debt notes: [`campus/LANGUAGE.md`](../../campus/LANGUAGE.md).  
Charter: [`01_CHARTER.md`](../../01_CHARTER.md) § Languages.

If this principle and campus LANGUAGE ever disagree, **Owner ratifies**; prefer one edit that updates both.

## Related

- [writing.md](writing.md)
- [university.md](university.md)
- [../constitution.md](../constitution.md)
