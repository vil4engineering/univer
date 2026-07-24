# Review 0001 — Что такое программирование?

- **Date:** 2026-07-24
- **Topic id:** `fundamentals/what-is-programming`
- **Chapter:** [fundamentals/what-is-programming/README.md](../fundamentals/what-is-programming/README.md)
- **DESIGN:** [fundamentals/what-is-programming/DESIGN.md](../fundamentals/what-is-programming/DESIGN.md)
- **Interview pack:** [notes/Interview-Pack.md](../fundamentals/what-is-programming/notes/Interview-Pack.md)
- **Reviewer:** dual-pass Reviewer (post Author v1; Author must not self-Accept)
- **Sources (non-SPA):**
  - Blob: https://github.com/vil4engineering/univer/blob/main/fundamentals/what-is-programming/README.md
  - Raw: https://raw.githubusercontent.com/vil4engineering/univer/main/fundamentals/what-is-programming/README.md
  - DESIGN blob: https://github.com/vil4engineering/univer/blob/main/fundamentals/what-is-programming/DESIGN.md

---

## Four gates

| Gate | Pass? | Note |
|------|-------|------|
| Beginner | **Pass*** | Чай / бутерброд / «не додумывает» — сильный вход. `*`: блок Swift `reduce` + Decimal — для сына позже; держать Level-1 чтение до «четыре формы», код — опциональный слой |
| Engineer | **Pass** | Coder vs Engineer, clarifying questions, SE vs programming, жизнь после merge |
| Interview | **Pass** | Секция Senior Interview + Interview-Pack; follow-ups и типичные ошибки на месте |
| University (≈10y) | **Pass** | Идея «формализация для буквального исполнителя» не привязана к API SwiftUI |

Все четыре gates проходят. Accept всё равно **не** даём: незакрытые Major (assets + один участок перегруза).

---

## Ten criteria

| Criterion | /10 | Note |
|-----------|-----|------|
| Главная идея | **9** | Явный before→after: «писать код» → «формализация для машины». Не «хороший текст ради текста» |
| Логика повествования | **8** | Интуиция → программа → программист → история → compiler → абстракции → пример → SE → interview → практика → рефлексия. Поток есть; середина чуть каталожная |
| Исторический контекст | **7** | Timeline Jacquard→Swift есть; мало *зачем* людям понадобились языки (боль, а не имена) |
| Глубина объяснения | **7** | Сильные определения и таблицы; местами «учат списком эпох», а не подводят к выводу |
| Диаграммы | **5** | Два Mermaid + ASCII-стек полезны; I1–I8 TODO — глава визуально недотянута до DoD |
| Практические примеры | **8** | Чай, заказ (4 формы), P1–P5; P5 — отличный Senior hook |
| Production perspective | **7** | Мост к SE и стеку университета есть; «Swift→iOS в проде» пока намёк, не сценарий бага/ограничений |
| Interview value | **8** | Вопросы совпадают с mental model; Pack короткий — ок для projection |
| Beginner friendliness | **7** | Сильный старт; плотные таблицы + Swift reduce — риск отпугнуть, если не пометить «можно пропустить код» |
| Долговечность | **9** | Idea spine; Swift только как форма записи |
| **Average** | **7.5** | Band: ship after small/medium fixes |

---

## Сильные стороны

1. **Mental-model shift** заявлен в Hero и закрыт в Рефлексии — это учебник, не статья.
2. **Буквальный исполнитель** (чай / «не додумывает») — Beginner Test почти выигран до середины главы.
3. **Четыре формы одной задачи** (язык → алгоритм → псевдокод → Swift) — лучший Production/Interview мост в главе.
4. **Coder vs Engineer** до первой строки кода — правильный Senior signal без снобизма.
5. **Compiler / Machine Code** без ложного «компьютер понимает Swift».
6. Явный запрет справочника в духе: языки меняются, идея нет.

---

## Что убрать

1. Ощущение **двойного контракта** в шапке: длинный passport + ссылка на DESIGN — для читателя Beta оставить одну «паспортную» полосу; DESIGN — для авторов (или свернуть).
2. В блоке истории — **лишние имена без боли** (Babbage/Ada как чеклист). Либо одна история с stakes, либо короче timeline.
3. TODO-плейсхолдеры I1–I8 в теле — либо вынести в DESIGN/Evidence, либо заменить минимальными SVG/Mermaid, чтобы не ломать immersion («глава ещё строится» на каждой секции).

---

## Что переписать

1. **История:** начать с проблемы («инструкции в голове мастера не масштабируются»), затем 2–3 шага эволюции, затем вывод «меняется язык, не идея». Сейчас вывод есть, а боль — слабее.
2. **Середина (Compiler → Абстракции → SE):** чуть сжать или явно сказать «три этажа одной лестницы», чтобы не звучало как три мини-главы подряд.
3. **Swift-пример:** одна строка комментария/подписи: «если код нечитаем — достаточно псевдокода выше» (Beginner gate hardening).

---

## Что добавить

1. **Assets I1–I8** (или сократить список до 3 must-have: человек–машина, timeline, четыре панели заказа).
2. Один **production failure** на 5–8 строк: дырка в спеке → баг в проде (например «чай готов, когда вкусно» → flaky QA / спор с заказчиком) — укрепляет Engineer + Interview.
3. Одна фраза-мост **iOS:** «на экране банка те же дырки: что считать балансом, что offline» — без ухода в UIKit.
4. Пометить Levels: что Level 1 обязателен, что Level 2 (абстракции/SE) — углубление.

---

## Связать с главами

| Сейчас | Предложение |
|--------|-------------|
| «Что читать дальше» — длинный граф будущих узлов | Держать **3 ближайших** якоря + «полный граф в DESIGN» |
| computer-science / development-principles | Ок как опоры |
| Compiler / CPU / Binary | Stub-ссылки ок; не обещать полноту Library |
| Path Beta Step 2 | Явно: после рефлексии → простая практика / «что такое компьютер» |

---

## Диаграммы (что стало понятнее?)

| Id / place | Что понятнее? | Keep / cut / TODO |
|------------|---------------|-------------------|
| Mermaid Задача→…→Результат | Цепочка формализации, не «магия кода» | **Keep** |
| Mermaid Swift→Compiler→CPU | Машина не «знает» Swift | **Keep** |
| ASCII этажи абстракций | Слои скрывают сложность | **Keep**; позже I4 |
| I1 человек–машина | Эмоциональный вход «инструкция между ними» | **TODO** must |
| I2 timeline | Эволюция языка, не идеи | **TODO** or cut names |
| I3 coder↔engineer | Разница фокуса | **TODO** nice |
| I5 Compiler-переводчик | Дубль Mermaid — не плодить | Merge with Mermaid or skip |
| I6 четыре панели | Одна идея / четыре формы | **TODO** must |
| I8 программа vs система во времени | SE horizon | **TODO** nice |

«Просто красиво» без ответа на вопрос — не добавлять.

---

## Findings (severity)

| Sev | Finding |
|-----|---------|
| Major | Визуальный DoD не закрыт (I1–I8 TODO); для Accept главы-эталона нужны ≥ must-have иллюстрации или явный cut списка в DESIGN |
| Major | Исторический блок ближе к каталогу имён, чем к истории проблемы — переписать под боль→идея |
| Minor | Passport + DESIGN link шумят для Student B |
| Minor | Нет явной пометки «код Swift можно пропустить на первом чтении» |
| Minor | Production→iOS мост слишком тонкий для gate Engineer на уровне «банк/offline» |
| Note | Interview-Pack можно позже добавить 1 example answer на clarifying questions |
| Note | После правок — второй review pass (0001b или amend Decision log) |

---

## Verdict

**Request changes**

Band **7.5 / 10** — сильный v1 учебника; не Accept как эталон процесса, пока не закрыты Major (история-как-боль + must-have visuals / cut).

### Owner decision

- [ ] Agree
- [ ] Override (why):
- Next Author actions:
  1. Переписать блок «Краткая история» (боль → 2–3 шага → вывод).
  2. Решить I1/I6 (и опционально I3): нарисовать или вычеркнуть из DoD в DESIGN.
  3. Подпись у Swift: Level-1 может остановиться на псевдокоде.
  4. Один короткий production/spec-hole vignette.
  5. Сжать «Что читать дальше» до 3 якорей.
  6. Новый Reviewer pass → цель **Accept**.


---

## Owner architecture follow-up (2026-07-24)

Binding decisions after review discussion:

1. **Title/why alignment:** chapter answers *Почему существует программирование?* (not dictionary *Что такое…*). Slug `what-is-programming` kept for link stability.
2. **Part I module** fixed: [`fundamentals/PART_I.md`](../fundamentals/PART_I.md) (0…9 why-spine).
3. **Teaching model** SoT: [`.ai/principles/teaching-model.md`](../.ai/principles/teaching-model.md) — one chapter = one fundamental question; ban term-catalog curricula.
4. Content items from peer feedback (emotional open, computer never wrong, Software/Hardware, spine diagram, mental-model block) remain **Author v1.1** — still under this Request changes + new items.

### Owner decision (architecture)

- [x] Agree — Part I + why-title + teaching-model
- [ ] Content v1.1 Author pass (pending command)

---

## Display follow-up (2026-07-24)

Owner agreed: flat Topic-id/Status strip → **Reader Header** + collapsible Learning / Engineering ([TOPIC_TEMPLATE](../campus/TOPIC_TEMPLATE.md) · [DISPLAY_0.1](../campus/DISPLAY_0.1.md)). Chapter 0 README updated to Student Mode default.

---

## Superseded for Accept decision

Author shipped **v1.1**. Re-pass: [0001b-what-is-programming.md](0001b-what-is-programming.md) (verdict **Accept**, pending Owner Agree).
