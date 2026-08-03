# Divide app into modules — faster builds (Jacob Bartlett)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `507903` |
| Related | [Modularization README](../README.md) |
| URL | https://blog.jacobstechtavern.com/p/modular-ios-architecture · https://jacobbartlett.substack.com/p/modular-architecture-for-apps |

---

## За 30 секунд

Модули ограничивают, сколько dependency graph пересобирается после изменения: чётче границы feature/service, параллельная компиляция, лучше Xcode caches. Сначала core module → feature modules; на масштабе всё равно бьёшься об invalidation базового слоя → смотри Bazel/Buck. Feature API vs Impl (Tuist-style) держит dependents стабильными, когда меняется impl.

## LinkedIn

Оригинальная короткая ссылка из Saved отдала 404 как post page; суть совпадает с постами Bartlett про modular architecture и build times.

## Попробуй применить

Сравни с [spm-common-services-features-cheatsheet](spm-common-services-features-cheatsheet.md) и заметкой JET про пять категорий.
