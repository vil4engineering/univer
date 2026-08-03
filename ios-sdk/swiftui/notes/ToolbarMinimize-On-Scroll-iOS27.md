# Hide navigation bar on scroll (toolbar minimize) — iOS 27

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `504273, 503345` |
| Related | [SwiftUI README](../README.md) |

---

## In 30 seconds

iOS 27 adds a system modifier to minimize / hide the navigation bar driven by scroll — no manual scroll-offset tracking.

## Before

Track scroll offset → direction → animate navbar state (fragile).

## After

Use the new toolbar minimize API (see TG digest / LinkedIn Artem Mirzabekian). Pair with NavigationStack.

## Digest

🔢 SwiftUI теперь умеет скрывать навигационную панель при скролле.

Раньше, чтобы скрыть или показать навигационную панель при скролле, нужно было отслеживать позицию прокрутки вручную. Слушать изменения scroll offset, вычислять направление, анимировать изменение состояния навбара. Это работало, но требовало лишнего кода и было не всегда предсказуемо.

В iOS 27 появился новый модификатор, который делает все это стандартными средствами, без костылей.


Как это работает:

Модификатор toolbarMinimizeBehavior позволяет указать, как должна вести себя панель инструментов при прокрутке содержимого.

ScrollView {
    ContentView()
}
.toolbarMinimizeBehavior(.onScrollDown, for: .navigationBar)

Когда пользователь скроллит вниз, навигационная панель минимизируется, освобождая больше места для контента. Все, что нужно было сделать разработчику - добавить одну строчку кода. Без UIScrollViewDelegate, без GeometryReader, без onPreferenceChange.


Когда это может пригодиться:

Такой подход полезен для экранов, где контент - главное. Ленты новостей, каталоги товаров, библиотеки, результаты поиска, длинные списки с большим количеством элементов. Все, где пользователь тратит много времени на скроллинг, а навигационная панель только занимает полезное пространство.


Что важно знать:

При минимизации навбара безопасная область (safe area) автоматически корректируется. Контент не перекрывается, отступы сохраняются. Это поведение работает по умолчанию и в большинстве случаев его достаточно.

Если н
