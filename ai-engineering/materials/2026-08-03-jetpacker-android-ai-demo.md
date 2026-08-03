# Jetpacker — Google AI Android demo (cross-platform ideas)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `506112, 506113, 506114, 506115` |
| Related | [AI materials](README.md) |

---

🎒 Jetpacker - открытый пример AI-приложения от Google
https://android-developers.googleblog.com/2026/07/build-intelligent-android-apps-introduction-jetpack.html

Google запустил серию статей о том, как превратить обычное приложение в интеллектуальное. Демо - Jetpacker, тревел-приложение, собранное к I/O целиком через Antigravity. Исходники открыты.

☝️ Полезно тем, что это разбор выбора архитектуры, а не просто «прикрутили LLM». На каждую фичу авторы объясняют, почему взяли именно этот подход:

🔴 On-device (Gemini Nano через ML Kit) - суммаризация маршрута (не хотим платить за облако на nice-to-have фичу), парсинг чеков (приватные данные не должны уезжать), голосовые заметки (приватность + работа без сети).

🔴 Cloud и hybrid (Firebase AI Logic) - Q&A о местах с гроундингом в Google Maps и веб (нужны знания о мире), черновики отзывов через новый Hybrid inference API (on-device где можно, облако как fallback), перевод чата с кастомной логикой выбора.

🔴 Системная интеграция - AppFunctions API, чтобы возможности приложения были доступны самой ОС.

🔴 Агентные сценарии (скоро появится) - ассистент бронирования на A2UI и ADK, где приложение работает фронтендом к мульти-агентной системе в облаке.

——————
💭 Редкий случай, когда показывают не только код, но и логику выбора между on-device и облаком и прочими механизмами, чтобы узнать ЗАЧЕМ. А услышать эту полезную информацию от Google - весьма полезно, чтобы понять однозначно - а куда идет разработка?

Telegram | Селеба | YouTube

## URL

https://android-developers.googleblog.com/2026/07/build-intelligent-android-apps-introduction-jetpack.html

## Note

Android-primary; kept as AI architecture ideas (feature→approach), not iOS chapter.
