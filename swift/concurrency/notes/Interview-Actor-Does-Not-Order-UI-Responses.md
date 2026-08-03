# Interview: actor does not guarantee UI response order

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `503061` |
| Related | [Interview-Pack](Interview-Pack.md) |

---

## За 30 секунд

Actor сериализует доступ к изолированному состоянию (data race не будет), но **каждый `await` — точка приостановки**: другая задача может зайти и изменить state; устаревший ответ может приехать позже нового.

## Дайджест

Собеседование: почему actor не гарантирует порядок ответов в UI?

Вопрос ловит тех, кто запомнил actors как защиту от гонок, но не отделяет data race от логической гонки.
Сильный ответ: actor сериализует доступ к своему изолированному состоянию. Но каждый await это точка приостановки, после нее другая задача может зайти в actor и изменить состояние. Data race не будет, зато устаревший ответ может приехать позже нового.

Мини-пример:

actor ImageLoader {
    private var cache: [URL: Data] = [:]

    func data(for url: URL) async throws -> Data {
        if let cached = cache[url] { return cached }

        let (data, _) = try await URLSession.shared.data(from: url)
        cache[url] = data
        return data
    }
}

Код безопасен по памяти: словарь не мутируется из двух потоков одновременно. Но если экран запросил картинку A, потом B, ответ A может завершиться позже и перерисовать UI старым состоянием, если caller не проверяет актуальный id.

На интервью хороший вывод звучит так: actor решает проблему изоляции данных, но порядок пользовательских намерений надо моделировать отдельно. Для SwiftUI это часто `.task(id:)`, сравнение requestID перед присваиванием или cancellation старой задачи.

Источник: The Swift Programming Language, Concurrency

#Swift #Concurrency #Interview #iOS #Actors

## Одной фразой

Data race ≠ logical race. Отменяй или supersede in-flight загрузки; version tokens или игнорируй устаревшие результаты на стороне UI.
