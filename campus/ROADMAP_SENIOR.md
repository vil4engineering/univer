# Roadmap — Senior iOS + постоянная база знаний

**Статус:** curriculum spine (статьи ещё не писать)  
**Горизонт:** 14–16 недель · 5–6 дней/нед · ~1.5–2.5 ч/день · ~140–180 ч  
**Аудитория:** Student A (Senior iOS) · побочный эффект - интервью · Level 1 на ключевых темах - для Student B  
**Path:** [Alpha](paths/alpha.md) · Evidence: [PROGRESS.md](PROGRESS.md)  
**Study execution:** по-прежнему **paused** до ратификации [V2_CHECKLIST](V2_CHECKLIST.md) - этот файл можно читать и уточнять уже сейчас  

## Решения (зафиксировано)

| Вопрос | Решение |
|--------|---------|
| Язык | RU-primary + EN terms ([LANGUAGE.md](LANGUAGE.md)) |
| Где лежит | `campus/ROADMAP_SENIOR.md` (не заменяет bootcamp stages Alpha) |
| Главный драйвер календаря | Interview readiness Senior+ при сохранении university-качества |
| Leadership / Fintech | Leadership = P0 · Fintech = P1 полный модуль |
| Deep Dive (L3) | max 1–2 onion/нед · дефолт exit = сильный L2 |
| Частные факты career | не всасывать · только public university + safe evidence |

## Принцип завершённости знания

Тема закрыта только если можно:

1. объяснить интуитивно  
2. показать на примерах  
3. применить на практике  
4. проверить тестом / self-check  
5. переиспользовать (lab / ADR / mock)

## Шаблон каждого урока (обязателен)

1. Problem  
2. Intuition  
3. Mental Model  
4. Fundamentals  
5. Practical Example  
6. Common Mistakes  
7. Senior Thinking  
8. Interview Questions  
9. Deep Dive  
10. Summary  
11. References  

Без лишней теории. Приоритет: production · labs · interview articulation.

## Глубина

| Код | Значение | Когда |
|-----|----------|--------|
| L1 | Student B / интуиция | учить сына или вход в тему |
| L2 | Engineer default | обычный exit для интервью |
| L3 | Deep Dive / trade-offs / internals | earned, не по умолчанию |

## Приоритеты модулей

| Код | Смысл |
|-----|--------|
| P0 | критично для offer loop / Senior+ |
| P1 | высокий рычаг |
| P2 | production craft |
| P3 | selective breadth |

## Универсальный article checklist

Перед статусом `interview_ready`:

- [ ] Заполнены все 11 секций урока (без filler)  
- [ ] Passport-хуки (проблема → зачем modern → где используется)  
- [ ] Intuition понятна для Student B (или есть Level 1)  
- [ ] Mental Model: схема или жёсткая аналогия  
- [ ] Practical Example крутится в lab / Reference World  
- [ ] ≥3 Common Mistakes (production)  
- [ ] Senior Thinking: trade-offs · failure modes · decision rule  
- [ ] ≥5 Interview Questions с *формой* ответа  
- [ ] Deep Dive ограничен или явно `deferred`  
- [ ] Completeness: Understand · Explain · Demonstrate · Practice · Reuse  
- [ ] Evidence: mock (RU → EN sketch) + lab id + строка в Progress  
- [ ] Связи: prerequisites · follow-ups · Skills  
- [ ] Без invented experience  

## Faculty mapping

| Модуль | Faculty |
|--------|---------|
| CS Fundamentals | Computer Science |
| Swift · Concurrency | Mobile Systems |
| UIKit · SwiftUI · Design Systems | Mobile Systems |
| Architecture | Software Engineering |
| Networking · Persistence · Security · Fintech | SE + Mobile (+ Backend hooks) |
| Testing · Debugging & Performance | SE + Infrastructure |
| Git · CI/CD · App Store · Feature Flags | Infrastructure / Product Engineering |
| AI-assisted SE | AI-assisted (Track 1) |
| Leadership | Engineering Leadership |
| Interview Preparation | Career Development |

---

## Календарный spine (14–16 недель)

| Недели | Фокус | Heat |
|-------:|-------|------|
| 1 | Campus OS + CS selective + Swift gate | ★★★ |
| 2–3 | Swift depth + Concurrency core | ★★★★★ |
| 4 | Concurrency production + async testing seed | ★★★★★ |
| 5 | UIKit as system | ★★★★ |
| 6 | SwiftUI as system | ★★★★ |
| 7–8 | Architecture: MVC → MVP → MVVM → Coordinator → Clean | ★★★★★ |
| 9 | Networking + Persistence | ★★★★★ |
| 10 | Security + Feature Flags | ★★★★ |
| 11 | Testing (XCTest → doubles → async → snapshot) | ★★★★★ |
| 12 | Debugging & Performance | ★★★★ |
| 13 | Design Systems + Git + CI/CD start | ★★★ |
| 14 | App Store + Fintech | ★★★★ |
| 15 | Leadership + AI-assisted SE | ★★★★ |
| 16 | Interview Preparation intensive | ★★★★★ |

Буфер: недели 14–16. Не резать Architecture / Concurrency / Testing / Interview Prep.

### Недельный ритм

| Блок | Время | Действие |
|------|-------|----------|
| Pulse | 10–15 м | 1 урок + lab gate |
| Learn | 45–75 м | шаблон урока (заметки, не эссе) |
| Practice | 30–60 м | lab / slice mini-project |
| Mock | 15–20 м | 2–3 вопроса вслух |
| Write-back | 10 м | Evidence + open questions |

---

## Граф зависимостей

```text
M01 CS ──┐
         ├─► M02 Swift ─► M03 Concurrency ─┬─► M04 UIKit ─┐
         │                                  ├─► M05 SwiftUI ┼─► M06 Architecture
         │                                  └───────────────┘         │
         │                                                            ▼
         │                                              M07 Networking ─► M08 Persistence
         │                                                     │              │
         │                                                     ▼              ▼
         │                                              M15 Feature Flags   M09 Security ─► M19 Fintech
         │                                                     │
         └─────────────────────────────────────────────────────┼─► M10 Testing ─► M11 Perf
                                                               │
M12 Git ─► M13 CI/CD ─► M14 App Store                          │
M16 Design Systems ◄── M04/M05                                 │
M17 AI-assisted ◄── M06 + M10                                  │
M18 Leadership ◄── delivery evidence                           │
M20 Interview Prep ◄── M03 + M06 + M10 + M18
```

---

# Модули

## M01 — Computer Science Fundamentals

| | |
|--|--|
| **Priority** | P2 (точечно P1 на слабых местах) |
| **Interview depth** | L1–L2 · L3 только если петля реально требует DSA |
| **Time** | 12–16 ч |
| **Prerequisites** | — |

**Scope (тонкий):** complexity · memory intuition · collections · hashing · HTTP/кэш на уровне продукта · consistency без академического CAP-курса.

**Labs**
- Big-O на реальных путях приложения (scroll / search / decode)
- Кэш + eviction на бумаге → маленький код
- Трассировка одного экрана: allocations / retains (sketch)

**Mini projects**
- Workbook «complexity этого PR» (3 сниппета)
- Tiny in-memory index с измеримыми trade-offs

**Interview questions**
- Как оцениваешь time/space до оптимизации?
- Array vs Set vs Dictionary - когда выбор важен на mobile?
- Что значит memory pressure для iOS process?
- Как объяснить eventual consistency продукту?
- Когда O(n²) на устройстве приемлемо?

**Article checklist**
- [ ] Карта решений complexity  
- [ ] Mental model коллекций с mobile examples  
- [ ] Связка с Networking  
- [ ] Mock EN: «optimize this list» ≤ 3 мин  

---

## M02 — Swift

| | |
|--|--|
| **Priority** | P0 |
| **Interview depth** | L2 · L3: ARC / generics / existentials по необходимости |
| **Time** | 16–20 ч |
| **Prerequisites** | M01 (light) |

**Labs**
- Циклы ARC: найти → сломать → объяснить
- Value vs reference mutation scenarios
- Protocol-oriented service + test double
- Модель ошибок: typed vs freeform

**Mini projects**
- Domain model library (money/date rules) + tests
- Пакет API surface: protocols · generics · дисциплина API

**Interview questions**
- Struct vs class - decision rule?
- Как ARC забирает память · где прячутся циклы?
- `any` vs `some` vs generics?
- Как проектируешь ошибки для call sites?
- Что ломается, если всё сделать class?

**Article checklist**
- [ ] ARC/ownership L2 + L3 deferred notes  
- [ ] POP → Architecture / Testing  
- [ ] Generics на production constraint  
- [ ] Spoken EN: ARC ≤ 2 мин  

---

## M03 — Swift Concurrency

| | |
|--|--|
| **Priority** | P0 |
| **Interview depth** | L2 обязательно · L3 actors / priority / executors earned |
| **Time** | 20–28 ч |
| **Prerequisites** | M02 |

**Labs**
- Completion-handler → `async`
- Cancellation-correct typeahead
- Actor-cache: race без actor → fix
- Аудит `MainActor` границ VM
- Structured vs unstructured `Task` lifetime bugs

**Mini projects**
- Fetcher с cancellation + in-flight coalescing
- Safe store actor + stress test

**Interview questions**
- Как убрать data races без заморозки main thread?
- Что решает structured concurrency?
- Actor vs serial-queue mental model?
- Как тестировать async без `sleep`?
- Что будет, если игнорировать cancellation?

**Article checklist**
- [ ] Mental model: tasks · isolation · suspension  
- [ ] Production pitfalls checklist  
- [ ] Evidence: failing race → fixed  
- [ ] Связь с Async Testing  

---

## M04 — UIKit

| | |
|--|--|
| **Priority** | P1 (P0 если компании UIKit-heavy) |
| **Interview depth** | L2 lifecycle/nav/memory · L3 layout/drawing selective |
| **Time** | 14–18 ч |
| **Prerequisites** | M02 · M03 полезен |

**Labs**
- Дневник VC lifecycle на реальном flow
- Ownership навигации: кто владеет stack?
- Cell reuse / prefetch bugs
- Responder chain / traits practice

**Mini projects**
- Multi-step UIKit flow с точками Coordinator
- Список со stable identity + стратегия высот

**Interview questions**
- Lifecycle при push/pop?
- Как не залить VC?
- Performance checklist table/collection?
- UIKit ↔ SwiftUI interop - когда?
- Кто владеет presentation: VC / Coordinator / Router?

**Article checklist**
- [ ] Lifecycle + memory paired  
- [ ] Navigation ownership card  
- [ ] Interop → SwiftUI  
- [ ] Lab: intentional leak → рассуждение  

---

## M05 — SwiftUI

| | |
|--|--|
| **Priority** | P0 |
| **Interview depth** | L2 state/nav/perf · L3 identity/diffing earned |
| **Time** | 14–18 ч |
| **Prerequisites** | M02 · M03 · M04 рекомендуется |

**Labs**
- Карта ownership состояния (`@State` / `@Binding` / `@Observable` / environment)
- NavigationStack path modeling
- Нестабильный identity → jank → fix
- Тонкий layout experiment

**Mini projects**
- Settings/form + validation VM
- Feed: async states + cancellation

**Interview questions**
- Что инвалидирует `body` · как держать дёшево?
- `@Observable` vs старые паттерны?
- Navigation + deep links?
- Когда UIKit всё ещё правильный инструмент?
- Как тестировать feature без snapshot-only мышления?

**Article checklist**
- [ ] State mental model  
- [ ] Performance anti-patterns  
- [ ] Navigation model  
- [ ] Связка с Architecture (границы VM)  

---

## M06 — Architecture

| | |
|--|--|
| **Priority** | P0 |
| **Interview depth** | L2 decisioning across styles · L3 Clean earned |
| **Time** | 24–32 ч |
| **Prerequisites** | M02–M05 (старт возможен после M03 на stubs) |

### M06a — MVC

- **Depth:** L1–L2 · **Time:** 3–4 ч  
- **Labs:** карта Massive VC · вынос одного service  
- **Mini project:** legacy screen → seams для эволюции  
- **Questions:** что такое Massive VC? куда утекает logic? когда MVC ещё ок?

### M06b — MVP

- **Depth:** L2 · **Time:** 3–4 ч  
- **Labs:** pure Presenter + passive view · unit tests  
- **Mini project:** Login MVP + fake view  
- **Questions:** MVP vs MVVM на iOS? куда класть navigation?

### M06c — MVVM

- **Depth:** L2–L3 (дефолтный ответ) · **Time:** 8–10 ч  
- **Labs:** `@Observable` VM + protocol deps · state machine load/error/empty  
- **Mini project:** feature VM с fakes · UI framework вне unit tests  
- **Questions:** что в VM / View / Domain? как не вырастить Massive VM?

### M06d — Coordinator

- **Depth:** L2 · **Time:** 5–6 ч  
- **Labs:** child coordinators · deep link · modal chains  
- **Mini project:** Tab + auth gate + feature coordinator  
- **Questions:** Coordinator vs Router? кто создаёт VM? как тестировать navigation policy?

### M06e — Clean Architecture

- **Depth:** L2 when-to-use · L3 layers selective · **Time:** 6–8 ч  
- **Labs:** dependency rule на реальном feature · use case + repository ports  
- **Mini project:** offline-capable skeleton Domain/Data/Presentation  
- **Questions:** когда Clean overkill? как защитить слои команде? связь с SPM modules?

**Article checklist (модуль)**
- [ ] Comparison matrix when / not when  
- [ ] Один feature минимум в двух стилях  
- [ ] ADR-lite шаблон  
- [ ] Spoken story: architectural change + trade-offs (career-safe)  

---

## M07 — Networking

| | |
|--|--|
| **Priority** | P0 |
| **Interview depth** | L2 · L3 URLSession/HTTP selective |
| **Time** | 12–16 ч |
| **Prerequisites** | M02 · M03 · M06c рекомендуется |

**Labs**
- Typed client: build → decode → error map
- Retry/idempotency для safe methods
- Token refresh race
- Offline / degraded UX contract

**Mini projects**
- Production-shaped API client + fakes
- Upload + progress + cancellation

**Interview questions**
- Как моделировать networking errors для UI и логов?
- Token refresh под concurrency?
- HTTP cache vs app cache?
- Как тестировать без flaky network?
- Background transfers - что реально можно на iOS? (в статьях сверять с Apple docs)

**Article checklist**
- [ ] Client layering diagram  
- [ ] Failure taxonomy  
- [ ] Lab: flaky server → resilience  
- [ ] Link → Security  

---

## M08 — Persistence

| | |
|--|--|
| **Priority** | P1 |
| **Interview depth** | L2 · L3 migrations/concurrency selective |
| **Time** | 10–14 ч |
| **Prerequisites** | M02 · M03 · M07 полезен |

**Labs**
- Decision matrix: File/Codable · Keychain · DB
- Migration dry-run narrative
- Threading rules выбранного стека (честно выбрать Core Data / GRDB / SwiftData)

**Mini projects**
- Offline draft store + conflict policy
- Cache TTL + invalidation

**Interview questions**
- Как выбираешь persistence tech?
- Стратегия миграций?
- Как убрать disk I/O с main thread?
- Partial writes / corruption?
- Что уходит в Keychain (PII)?

**Article checklist**
- [ ] Decision matrix  
- [ ] Один стек L2 + comparison cards  
- [ ] Lab: main-thread I/O smell → fix  

---

## M09 — Security

| | |
|--|--|
| **Priority** | P1 (P0 для fintech-таргетов) |
| **Interview depth** | L2 · L3 crypto только по необходимости |
| **Time** | 8–12 ч |
| **Prerequisites** | M07 · M08 |

**Labs**
- Keychain wrapper + accessibility
- ATS / transport checklist
- Что *не* обещаешь про jailbreak/debug
- Logging redaction audit

**Mini projects**
- Secure session + biometric gate sketch
- Threat model one-pager для payment-like screen

**Interview questions**
- Где живут tokens и почему?
- Certificate pinning trade-offs?
- Mobile threat model последнего приложения?
- Secrets в logs/analytics?
- Biometrics vs passcode fallback?

**Article checklist**
- [ ] Threat-model template  
- [ ] Secrets lifecycle  
- [ ] Forward links → Fintech  
- [ ] Mock EN security story без overclaim  

---

## M10 — Testing

| | |
|--|--|
| **Priority** | P0 |
| **Interview depth** | L2 · async L2–L3 |
| **Time** | 16–22 ч |
| **Prerequisites** | M02 · M03 · M06c |

### M10a — XCTest / Swift Testing
Labs: targets · given/when/then · deterministic fixtures  
Questions: unit vs UI? как держать suite быстрым?

### M10b — Test Doubles
Labs: stub/fake/spy/mock на одном protocol seam  
Mini project: VM tests + spy repository + fake clock  
Questions: mock vs fake? когда mocking = design smell?

### M10c — Async Testing
Labs: expectations/confirmation · cancellation · без `sleep`  
Questions: как тестировать `async`? откуда flaky?

### M10d — Snapshot Testing
Labs: traits · Dynamic Type · dark mode · CI stewardship  
Questions: когда snapshots помогают / вредят? как ревьюить diffs?

**Article checklist**
- [ ] Test strategy для одного feature  
- [ ] Doubles glossary + code  
- [ ] Async recipes без arbitrary sleep  
- [ ] Snapshot policy (что является golden)  

---

## M11 — Debugging & Performance

| | |
|--|--|
| **Priority** | P1 |
| **Interview depth** | L2 method/tooling · L3 Instruments selective |
| **Time** | 10–14 ч |
| **Prerequisites** | M03–M05 · M10 полезен |

**Labs**
- Hang/jank reproduction recipe
- Allocations: retain cycle / abandoned cache
- Time Profiler на scroll path
- `os_signpost` на critical journey

**Mini projects**
- Perf budget: launch + first interaction
- Bug clinic write-up: symptom → hypothesis → tool → fix

**Interview questions**
- Production-only crash - с чего начнёшь?
- Main-thread checklist?
- Как приоритизировать perf с продуктом?
- Memory graph - первый взгляд?
- Как MetricKit меняет процесс?

**Article checklist**
- [ ] Debugging playbook  
- [ ] Perf budgets  
- [ ] Lab before/after (хотя бы local numbers)  

---

## M12 — Git Workflow

| | |
|--|--|
| **Priority** | P2 |
| **Interview depth** | L1–L2 |
| **Time** | 4–6 ч |
| **Prerequisites** | — |

**Labs:** branch model · merge vs rebase card · bisect · Conventional Commits  
**Mini project:** PR template + review checklist для labs  
**Questions:** recovery после плохого merge? что делает PR reviewable? когда squash?

**Article checklist**
- [ ] Team workflow card  
- [ ] Safe recovery subset  
- [ ] Link → Leadership (code review)  

---

## M13 — CI/CD

| | |
|--|--|
| **Priority** | P2 (P1 если нужен Lead signal) |
| **Interview depth** | L2 |
| **Time** | 8–10 ч |
| **Prerequisites** | M10 · M12 |

**Labs:** PR pipeline lint/build/test · caching notes · quality gates · artifacts  
**Mini project:** GitHub Actions или Xcode Cloud для lab package  
**Questions:** что в CI vs local? как ускорять CI? как гейтить release?

**Article checklist**
- [ ] Pipeline diagram  
- [ ] Flaky-test policy  
- [ ] Release train → App Store  

---

## M14 — App Store Lifecycle

| | |
|--|--|
| **Priority** | P2 |
| **Interview depth** | L1–L2 |
| **Time** | 5–7 ч |
| **Prerequisites** | M13 полезен |

**Labs:** versioning · phased release · post-release crash triage · privacy labels notes  
**Mini project:** release runbook для sample app  
**Questions:** hot fix process? как снижать release risk? что мониторить после ship?

**Article checklist**
- [ ] Release runbook  
- [ ] Rollback vs fix-forward  
- [ ] Thin compliance list + links  

---

## M15 — Feature Flags

| | |
|--|--|
| **Priority** | P2 |
| **Interview depth** | L2 |
| **Time** | 5–7 ч |
| **Prerequisites** | M06 · M07 |

**Labs:** release/experiment/ops flags · sticky assignment · kill switch · cleanup debt  
**Mini project:** flagged checkout-like path + offline-safe defaults  
**Questions:** flags × cache/persistence? как не копить flag debt? кто владеет rollout?

**Article checklist**
- [ ] Taxonomy  
- [ ] Lifecycle create → roll out → remove  
- [ ] Failure modes  

---

## M16 — Design Systems

| | |
|--|--|
| **Priority** | P2 |
| **Interview depth** | L1–L2 |
| **Time** | 6–8 ч |
| **Prerequisites** | M04 или M05 |

**Labs:** tokens · component API · a11y (Dynamic Type · VoiceOver)  
**Mini project:** tiny DS: Button/TextField/ListRow + SwiftUI/UIKit adapter  
**Questions:** versioning DS? как убивать one-off UI? HIG vs brand tension?

**Article checklist**
- [ ] Token → component → screen  
- [ ] A11y non-negotiables  
- [ ] Contribution rules  

---

## M17 — AI-assisted Software Engineering

| | |
|--|--|
| **Priority** | P1 (Track 1) |
| **Interview depth** | L2 process (не tool trivia) |
| **Time** | 8–10 ч |
| **Prerequisites** | M06 · M10 |

**Labs:** agent brief → diff → review → tests · prompt contracts · сверка с Apple docs  
**Mini project:** skill/checklist «feature with evidence» для university  
**Questions:** как сохранить ownership когда AI пишет код? что никогда не merge blindly?

**Article checklist**
- [ ] Safe workflow + human gates  
- [ ] Mapping на Skills registry  
- [ ] Пример: AI draft → ты владеешь ADR  

---

## M18 — Leadership

| | |
|--|--|
| **Priority** | P0 (Senior+/Lead loops) |
| **Interview depth** | L2 stories |
| **Time** | 10–14 ч (+ ongoing drills) |
| **Prerequisites** | Architecture + delivery modules · career-safe anchors |

**Labs**
- Ownership boundary прошлого feature (SOT-safe)
- Review PR вслух
- Mentoring plan skeleton
- Decision log

**Mini project**
- Portfolio из 5 stories → competency model (Ownership · Architecture · Decisions · Review · Mentoring)

**Interview questions**
- Influence without authority?
- Как поднимаешь quality bar?
- Delivery under ambiguity?
- Mentoring example?
- Conflict / cross-functional translation?

**Article checklist**
- [ ] Stories × competencies  
- [ ] Anti-patterns: overclaim · vagueness · hero narrative  
- [ ] EN sketches для top-5  

---

## M19 — Fintech

| | |
|--|--|
| **Priority** | P1 |
| **Interview depth** | L2 product+risk · L3 protocols selective |
| **Time** | 10–14 ч |
| **Prerequisites** | M07–M09 · M15 · Testing |

**Labs**
- Money: decimal vs minor units
- Idempotent operations
- Receipt / uncertain server state UX
- Session timeout / step-up auth sketch

**Mini projects**
- Payment/transfer state machine + flags + offline rules + audit mindset

**Interview questions**
- Как моделируешь money?
- Когда retry безопасен?
- Uncertain server state?
- Что никогда не хранишь (PCI awareness)?
- Как расследовать duplicate charge?

**Article checklist**
- [ ] Risk + state machine  
- [ ] Integration Security/Networking  
- [ ] Incident scenario  
- [ ] Только career-safe hooks  

---

## M20 — Interview Preparation

| | |
|--|--|
| **Priority** | P0 |
| **Interview depth** | meta: форсировать L2 articulation |
| **Time** | 16–24 ч (неделя 16 + ongoing) |
| **Prerequisites** | M03 · M06 · M10 · M18 minimum |

**Labs**
- Daily 20 мин spoken (RU → EN)
- System-design lite: offline sync / feed / messaging
- Live coding hygiene: clarify → tests → iterate
- Post-mock competency tagging

**Mini projects**
- Question bank → module articles
- Mock board: competency × evidence × weak tags

**Meta questions**
- Hard trade-off story
- Production incident walkthrough
- How do you test this?
- Design X under mobile constraints
- Leadership / mentoring story

**Article checklist**
- [ ] Answer shape: problem → boundary → decision → failure → outcome  
- [ ] Live coding checklist  
- [ ] Weekly mock schedule  
- [ ] Явно: university ≠ private career SOT  

---

## Definition of done модуля

Модуль curriculum-complete, когда:

1. Есть список уроков (достаточно **titles**)  
2. Labs + mini projects встроены в недели  
3. Прикреплён interview bank  
4. Article checklist = exit gate  
5. Можно повесить hooks на Path Alpha stages после unlock  

## Что намеренно не делается в этом файле

- Тела статей / контент 11 секций  
- Массовый перенос Library  
- AI Technology Track 2 (отдельный spine Gamma; здесь только Track 1)  
- Commit/push (только по просьбе)

## Следующий шаг после ратификации

1. Unlock Study в `PROJECT_STATUS` / V2  
2. Сгенерировать **titles-only** lesson index по модулю (начать с M02 + M03)  
3. Завести lab ids в `campus/labs/`  
4. Писать статьи по одному модулю: `пишем M0X`
