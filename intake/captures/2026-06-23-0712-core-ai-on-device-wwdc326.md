---
source: telegram-saved
telegram_id: 502753
captured: 2026-06-23
url: https://developer.apple.com/videos/play/wwdc2026/326/
status: raw
tags: [on-device, core-ai, wwdc2026-326, model-delivery, vision-language-pipeline]
---

# Integrate on-device AI models into your app using Core AI

Forwarded channel digest of WWDC26 session 326.

Demo: vocabulary app — image + text prompt → flashcard (word, translation, example).

## Capture

Integrate on-device AI models into your app using Core AI

Крутой разбор AI On-device на примере приложения для изучения слов, где картинка и текстовый запрос превращаются в карточку со словом, переводом и примером.

Главная идея видео в том, что задачу лучше разделить на две отдельные модели: одна отвечает за сегментацию изображения, другая за генерацию языковой части карточки. Для сегментации автор берет SAM 3, а для текста - Qwen, потому что он многозадачный, умеет работать с большим числом языков и подходит для генерации контекстных примеров.

Отдельно полезен блок про внедрение и доставку моделей: показывают, как использовать готовые модели, как загрузка и специализация могут тормозить первый запуск, и почему стоит продумывать отдельный сценарий первого входа, а не вешать всё на обычный экран. Еще один момент - подход к размеру и доставке: модели не стоит бездумно класть в приложение, лучше подгружать их по требованию и заранее частично компилировать, чтобы сократить ожидание пользователя.

## Why it might belong in univer

Complements `ai-engineering/foundation-models/` and `projects/flip-english/`: multi-model on-device pipeline + model delivery / first-launch UX, not only Foundation Models API.

## Open decision

Watch WWDC 326, then decide: improve foundation-models / apple-intelligence notes, or flip-english engineering notes — or both.
