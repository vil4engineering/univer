# Hide navigation bar on scroll (toolbar minimize) — iOS 27

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | partial |
| Source | Telegram Saved `504273, 503345` |
| Related | [SwiftUI README](../README.md) |

---

## За 30 секунд

В iOS 27 системный модификатор минимизирует / скрывает navigation bar по скроллу — без ручного tracking scroll offset.

## Было

Tracking scroll offset → direction → анимация состояния navbar (хрупко).

## Стало

Новый toolbar minimize API (см. TG digest / LinkedIn Artem Mirzabekian). Пара с `NavigationStack`.

## Выжимка

🔢 SwiftUI теперь умеет скрывать navigation bar при скролле.

Раньше для hide/show navbar при скролле нужно было вручную слушать scroll offset, считать направление и анимировать state — работало, но много кода и непредсказуемо.

В iOS 27 модификатор делает это стандартными средствами.

**Как работает:**

`toolbarMinimizeBehavior` задаёт поведение toolbar при прокрутке:

    ScrollView {
        ContentView()
    }
    .toolbarMinimizeBehavior(.onScrollDown, for: .navigationBar)

При скролле вниз navigation bar минимизируется — больше места для контента. Одна строка: без `UIScrollViewDelegate`, без `GeometryReader`, без `onPreferenceChange`.

**Когда пригодится:**

Экраны, где контент главный: ленты, каталоги, библиотеки, поиск, длинные списки — везде, где пользователь много скроллит, а navbar только занимает место.

**Что важно знать:**

При минимизации safe area корректируется автоматически — контент не перекрывается, отступы сохраняются. По умолчанию этого обычно достаточно.

Если нужно кастомное поведение — смотри варианты `toolbarMinimizeBehavior` и документацию iOS 27 beta.
