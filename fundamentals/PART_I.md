# Part I — Foundations

**Status:** Owner architecture (2026-07-24) · binding spine  
**SoT (agents):** [`.ai/principles/teaching-model.md`](../.ai/principles/teaching-model.md)

Первый модуль университета. Не словарь терминов. Каждая глава — **ответ на один why**.

```text
0 Why programming exists
  → 1 Computer (literal executor)
  → 2 How a program becomes action
  → 3 Binary → 4 Machine Code → 5 Assembly → 6 Compiler
  → 7 Algorithms → 8 Languages
  → 9 What it means to be a Software Engineer
```

Строгое «что такое программирование?» как словарное определение — **после** исполнителя, инструкции, алгоритма и программы (не единственная работа главы 0).

---

## Sequence

| # | Title (reader) | Fundamental why | Topic | Status |
|---|----------------|-----------------|-------|--------|
| 0 | [Почему существует программирование?](what-is-programming/) | Почему компьютеру вообще нужны программы? | `fundamentals/what-is-programming` | **v1.1** · [0001](../reviews/0001-what-is-programming.md) · [0001b](../reviews/0001b-what-is-programming.md) |
| 1 | Что такое компьютер? | Почему нам нужен буквальный исполнитель? | `fundamentals/what-is-a-computer` | planned |
| 2 | Как компьютер исполняет программу? | Почему инструкция превращается в действие? | `fundamentals/how-computer-runs-a-program` | planned |
| 3 | Binary | Почему компьютеры понимают только Binary? | `fundamentals/binary` | planned |
| 4 | Machine Code | Почему CPU не исполняет текст «как есть»? | `fundamentals/machine-code` | planned |
| 5 | Assembly | Почему язык ближе к человеку, но ещё у железа? | `fundamentals/assembly` | planned |
| 6 | Compiler | Почему компьютер не понимает Swift? | `fundamentals/compiler` | planned |
| 7 | Алгоритмы | Почему недостаточно «сказать примерно»? | `fundamentals/algorithms` | planned |
| 8 | Языки программирования | Почему языков много, а идея одна? | `fundamentals/programming-languages` | planned |
| 9 | Что значит быть Software Engineer? | Почему «написать код» недостаточно? | `fundamentals/what-is-a-software-engineer` | planned |

Пустые папки **не** создавать пачкой. Следующая глава — только через [chapter-fill](../.ai/workflows/chapter-fill.md) (DESIGN → Review → Approve → write).

---

## Path hooks

- Student B: [Path Beta](../campus/paths/beta.md) follows this Part I order.  
- Student A: Alpha Stage 0 mental reset = chapter 0, then deep track; Part I remains the foundation shelf.

---

## Rule reminder

| ❌ | ✅ |
|----|----|
| Глава «Переменные / Функции / Классы» | Глава как ответ на проблему |
| Title *What is X?* при тексте *Why X?* | Title = вопрос, на который отвечает тело |
| Каталог API как spine | Идея → реализации (Swift/iOS later) |
