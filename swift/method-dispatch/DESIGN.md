# DESIGN — Почему один вызов метода в Swift может идти разными путями?

**Статус:** Draft v1 · Owner: Maxim · Phase B written with chapter (Owner request 2026-07-31) · Accept pending Reviewer  
**Topic id:** `swift/method-dispatch`  
**Faculty:** Mobile Systems · Swift  
**Paths:** после входа в Swift · рядом с types / protocols / memory  
**Interview Heat:** ★★★★  
**Levels:** 1–2 обязательны · 3 = лёгкий мост (SIL / metadata), без полного SIL dump

**Pipeline:** [chapter-fill](../../.ai/workflows/chapter-fill.md) · [chapter-shape](../../.ai/principles/chapter-shape.md)

---

## Passport (контракт)

1. **What:** идея *method dispatch* — как выбирается, *какая* реализация метода реально побежит.  
2. **Problem:** одно и то же имя метода может значить разные реализации (наследование, протоколы, Obj-C).  
3. **Why:** без выбора реализации CPU не знает, куда прыгать; язык должен задать стратегию.  
4. **Before:** прямой вызов (C / известный адрес) · виртуальные таблицы (C++ / Obj-C classes) · message send (Objective-C).  
5. **Why not enough:** один механизм не покрывает value types, class polymorphism, protocol existential и Cocoa interop.  
6. **Modern:** четыре стратегии Swift — Static · Vtable · Witness table · Obj-C dynamic.  
7. **Next:** Protocols · Types & Generics · Memory/layout · Performance.  
8. **Where used:** каждый вызов метода; интервью Senior iOS; оптимизация / `final` / existential vs generic.

**Fundamental why:** Почему компилятор/runtime не всегда может вызвать метод «напрямую» — и зачем тогда несколько стратегий?

**H1 (invitation):** Почему один вызов метода в Swift может идти разными путями?

**Главная мысль:** Диспетчеризация — не «магия OOP», а ответ на вопрос *какой код исполнить*. Разные формы полиморфизма → разные таблицы и моменты решения.

**Анти-цель:** словарь ключевых слов · каталог атрибутов · «список из четырёх пунктов без проблемы» · углубление в SIL/LLVM как отдельный курс.

---

## Выносы по аудиториям

| Аудитория | Что уносит |
|-----------|------------|
| Школьник / Level 1 | Картинка: «кнопка → какая дверь открыть» · static = адрес известен сразу |
| Junior | Четыре вида + когда какой · struct ≠ class для вызова |
| Middle | existential → witness · generic → часто static · `final` / WMO |
| Senior / интервью | Не путать «runtime» с Obj-C dynamic · порядок стоимости · `dynamic` / KVO |

---

## Карта страницы (chapter-shape)

| Секция | Содержание дизайна |
|--------|-------------------|
| **Интуиция** | Ресепшен отеля: имя гостя одно, комнаты разные — нужно понять *кого* звать |
| **Проблема** | `x.foo()` не указывает адрес сам по себе, если тип динамический / протокольный |
| **История** | C direct → C++ vtable → Obj-C msgSend → Swift разделяет стратегии |
| **Как это работает** | Четыре стратегии + таблица «когда какая» |
| **Внутри** | Лёгкий мост: metadata / existential container; SIL deferred |
| **Пример** | Четыре коротких сниппета одного `printMessage` |
| **Production** | Привычка: `final` / конкретный тип / generic vs `any` · не выдуманный кейс |
| **Интервью** | Проекция Q · follow-ups · типичные ошибки |
| **Лабораторная** | Упражнение «угадай dispatch» (без обязательного playground в v1) |
| **Конспект** | Текст без ссылок |
| **Рефлексия** | Сдвиг: вызов ≠ всегда dynamic |
| **Дальше** | Protocols (контракт) или Types & Generics |

---

## Диаграммы

1. Mermaid: call site → четыре ветки (static / vtable / witness / objc).  
2. Таблица: стратегия · момент решения · типичный тип · грубая стоимость.

---

## Связанные темы

| | |
|--|--|
| **Prerequisites** | [Зачем Swift](../what-is-swift/) · базовые class/struct · [Protocols](../protocols/) (можно параллельно) |
| **Siblings** | [Types & Generics](../types-generics/) · [Memory & ARC](../memory-arc/) · [Syntax Q48](../syntax/) |
| **Glossary** | Static Dispatch · Vtable · Witness Table · Dynamic Dispatch · Existential · Compiler |
| **Next (student)** | Protocols — контракт без адреса |

---

## Критерии приёмки дизайна

- [x] Один why, не «что такое vtable»  
- [x] Идея раньше каталога  
- [x] Анти-цель ясна  
- [x] L3 не раздувает главу  
- [x] Термины → Glossary  
- [ ] Formal Design Review / Accept (pending)

---

## План написания (Phase B)

1. Reader Header + Learning meta.  
2. Интуиция → Проблема → короткий History.  
3. Четыре стратегии + mermaid + таблица.  
4. Пример ×4 · Production habit · Interview · Lab stub.  
5. Конспект · Рефлексия · Дальше · Engineering meta.
