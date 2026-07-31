# Glossary

Словарь **Engineering Builder** — короткие ответы «зачем этот термин», не учебник на час.

В главах термин с оттенком ведёт **сразу сюда** (тот же Glossary, что в сайдбаре).  
Глубокий урок — на факультете; толстые AI-карточки — в [AI Dictionary](../ai-engineering/dictionary/).

| Поле | Смысл |
|------|--------|
| **Term** | Имя as-is (обычно English) |
| **Domain** | К какому этажу относится (Backend, Mobile · Memory/ARC, Architecture…) |
| **Def** | 1–3 предложения: зачем / чем отличается |

Сортировка для поиска — **алфавит**. Смысл — колонка Domain.

---

## A–Z (индекс)

| Term | Domain | Коротко |
|------|--------|---------|
| [ADR](#glossary-adr) | Architecture | Запись архитектурного решения |
| [Actor](#glossary-actor) | Mobile · Concurrency | Сериализованный доступ к состоянию |
| [Algorithm](#glossary-algorithm) | Computer Science | Однозначные шаги к результату |
| [ARC](#glossary-arc) | Mobile · Memory / ARC | Автоподсчёт ссылок |
| [ATS](#glossary-ats) | Mobile · Networking | Политика безопасного транспорта |
| [Binary](#glossary-binary) | Computer Science | Представление для машины |
| [CI/CD](#glossary-ci-cd) | Infrastructure | Автосборка, тесты, доставка |
| [Compiler](#glossary-compiler) | Computer Science | Перевод языка → machine code |
| [CPU](#glossary-cpu) | Computer Science | Исполнитель machine code |
| [Dynamic Dispatch](#glossary-dynamic-dispatch) | Mobile · Swift / Runtime | Obj-C message send (`objc_msgSend`) |
| [JSON](#glossary-json) | Backend · Data | Текстовый обмен данными |
| [LLM](#glossary-llm) | AI | Языковая модель (см. Dictionary) |
| [Machine Code](#glossary-machine-code) | Computer Science | Инструкции для CPU |
| [MCP](#glossary-mcp) | AI | Протокол инструментов для AI |
| [Optional](#glossary-optional) | Mobile · Swift | `.some` / `.none` |
| [Program](#glossary-program) | Computer Science | Алгоритм в форме для машины |
| [RAG](#glossary-rag) | AI | Retrieval + генерация |
| [REST](#glossary-rest) | Backend · Networking | Стиль HTTP API |
| [Retain cycle](#glossary-retain-cycle) | Mobile · Memory / ARC | Взаимные strong → утечка |
| [SOLID](#glossary-solid) | Architecture | Пять принципов дизайна ООП |
| [SPM](#glossary-spm) | Mobile · Tooling | Swift Package Manager |
| [Static Dispatch](#glossary-static-dispatch) | Mobile · Swift / Runtime | Прямой вызов; адрес на compile time |
| [Task](#glossary-task) | Mobile · Concurrency | Единица structured concurrency |
| [URLSession](#glossary-urlsession) | Mobile · Networking | HTTP(S) клиент Apple |
| [Vtable](#glossary-vtable) | Mobile · Swift / Runtime | Таблица методов class для override |
| [Witness Table](#glossary-witness-table) | Mobile · Swift / Runtime | Таблица соответствия протоколу |
| [unowned](#glossary-unowned) | Mobile · Memory / ARC | Не-Optional ссылка без retain |
| [weak](#glossary-weak) | Mobile · Memory / ARC | Optional ссылка без retain |

Домены на витрине: [Computer Science](../fundamentals/PART_I.md) · [Mobile](../campus/faculties/mobile-systems.md) · [Backend](../campus/faculties/backend.md) · [AI Dictionary](../ai-engineering/dictionary/).

---

## Базовые CS / Architecture / AI (seed)

<a id="glossary-algorithm"></a>
**Algorithm** · *Computer Science*

Конечная, упорядоченная, по возможности однозначная последовательность шагов к результату. Без алгоритма «программа» — только пожелание машине.

<a id="glossary-program"></a>
**Program** · *Computer Science*

Алгоритм, записанный в форме, которую машина умеет исполнять (Software для Hardware).

<a id="glossary-binary"></a>
**Binary** · *Computer Science*

Представление данных и инструкций «нулями и единицами», с которым работает цифровая машина. Глубже — главы Computer Science.

<a id="glossary-machine-code"></a>
**Machine Code** · *Computer Science*

Инструкции в форме, готовой к исполнению CPU (после Compiler / Assembler).

<a id="glossary-compiler"></a>
**Compiler** · *Computer Science*

Переводчик: язык, удобный человеку (например Swift) → форма ближе к machine code. Не «магия», а ответ на боль писать сырые команды.

<a id="glossary-cpu"></a>
**CPU** · *Computer Science*

Процессор — Hardware, который исполняет machine code. Буквальный исполнитель на уровне железа.

<a id="glossary-solid"></a>
**SOLID** · *Architecture · Software Engineering*

Пять принципов проектирования (SRP, OCP, LSP, ISP, DIP): помогают системам жить годами, а не только «завестись в файле».

<a id="glossary-llm"></a>
**LLM** · *AI*

Large Language Model — модель, обученная предсказывать следующий token. Полная карточка: [AI Dictionary · LLM](../ai-engineering/dictionary/terms/llm.md).

<a id="glossary-rag"></a>
**RAG** · *AI*

Retrieval-Augmented Generation — сначала достаём факты из базы, потом генерируем ответ. Карточка: [AI Dictionary · RAG](../ai-engineering/dictionary/terms/rag.md).

---

## Подробные карточки (iOS / Swift и соседние)

Якоря `#glossary-*` сохранены для старых ссылок. Где есть Domain — смотри индекс A–Z.

## iOS / Swift

<a id="ios-swift"></a>

Section **XI · Summary** on the [iosiq roadmap](https://iosiq.ru/roadmap.html): terms and short definitions.

### Memory and data model

<a id="glossary-arc"></a>
**ARC** — *Automatic Reference Counting* — automatic reference counting; an object is freed when it has zero strong references.

<a id="glossary-weak"></a>
**weak** — optional reference (`Optional`); does not retain the object — typical way to break a cycle with a delegate or closure.

<a id="glossary-unowned"></a>
**unowned** · *Mobile Systems · Memory / ARC*

Зачем: чтобы разорвать retain cycle между объектами, когда срок жизни «другого» объекта **гарантированно** не короче текущего. В отличие от `weak`, ссылка не `Optional` и сама не становится `nil` — при ошибке жизненного цикла возможен crash. Related: [weak](#glossary-weak), [retain cycle](#glossary-retain-cycle), [ARC](#glossary-arc).

<a id="glossary-retain-cycle"></a>
**Retain cycle** — mutual strong references between objects (or `self` in `@escaping` without `weak`), so memory is never released.

<a id="glossary-value-type"></a>
**Value type** — `struct` / `enum` (etc.): copy semantics; shared ownership via buffer reference with COW collections.

<a id="glossary-reference-type"></a>
**Reference type** — `class`: one heap instance, identity via reference; lifetime managed by ARC.

<a id="glossary-cow"></a>
**COW** — *Copy-On-Write* — when copying large value types (e.g. `Array`), the buffer is shared until the first mutation, then copied.

<a id="glossary-shallow-copy"></a>
**Shallow copy** — duplicates the top-level container, but nested **reference** objects remain the same instances: copy and original share references to the same `class` objects (or the same buffer until a COW break).

<a id="glossary-deep-copy"></a>
**Deep copy** — copies the data graph “deeply”: nested objects get independent copies as required (often manually or via `Codable`/archiving); Swift has no universal automatic deep copy for classes.

### Swift Concurrency

<a id="glossary-actor"></a>
**actor** — Swift type guaranteeing *serialised access* to its state through isolation on its executor.

<a id="glossary-mainactor"></a>
**@MainActor** — global actor binding execution to the main queue (UI and typical main-thread API).

<a id="glossary-sendable"></a>
**Sendable** — marker protocol for types safe to cross *isolation domains* without data races.

<a id="glossary-nonisolated"></a>
**nonisolated** — member of an actor-isolated type (e.g. `@MainActor`) explicitly run **outside** that actor’s isolation; removes automatic serialization — you must control what is passed and from where it is called.

<a id="glossary-nonisolated-unsafe"></a>
**nonisolated(unsafe)** — like `nonisolated`, but the compiler **does not check** state safety; only as a narrow exception when the invariant is proven manually.

<a id="glossary-async-await"></a>
**async / await** — at `await` execution suspends; the thread is not blocked waiting on I/O — the runtime can do other work (alternative to completion-handler chains).

<a id="glossary-task"></a>
**Task** — unit of structured concurrency: inherits priority and context (including cancellation from the parent task).

<a id="glossary-structured-concurrency"></a>
**Structured concurrency** — hierarchy of `Task` / `async let` / `TaskGroup`: on scope exit the parent waits for child tasks; cancellation propagates downward.

<a id="glossary-isolation"></a>
**Isolation** — compiler rule: actor / `@MainActor` code runs only on the allowed executor or via `await` when crossing a boundary.

### Types and protocols

<a id="glossary-existential"></a>
**Existential** — type `any P`: runtime “box” for any conformance to protocol `P` (existential container / witness table).

<a id="glossary-static-dispatch"></a>
**Static Dispatch** · *Mobile · Swift / Runtime*

Зачем: вызвать метод по адресу, известному на compile time — без поиска в таблице в runtime. Типично для `struct` / `enum`, `final`, часто после specialization generics. Глубже: [method dispatch](../swift/method-dispatch/).

<a id="glossary-vtable"></a>
**Vtable** · *Mobile · Swift / Runtime*

Зачем: выбрать реализацию метода class по динамическому типу (в т.ч. `override`), когда переменная объявлена базовым типом. Таблица указателей живёт в metadata объекта. Глубже: [method dispatch](../swift/method-dispatch/).

<a id="glossary-witness-table"></a>
**Witness Table** · *Mobile · Swift / Runtime*

Зачем: связать existential протокола (`any P`) с конкретной реализацией требований у скрытого типа. Не путать с vtable class и с generic constraint (там часто static). Глубже: [method dispatch](../swift/method-dispatch/).

<a id="glossary-dynamic-dispatch"></a>
**Dynamic Dispatch** · *Mobile · Swift / Runtime*

Зачем: резолвить метод через Objective-C runtime (`objc_msgSend`) — `@objc`, `dynamic`, KVO, swizzling. Не синоним любого runtime-вызова: vtable и witness тоже runtime, но это механизмы Swift. Глубже: [method dispatch](../swift/method-dispatch/).

<a id="glossary-opaque"></a>
**Opaque** — type `some P`: concrete type known to the compiler, exposed only as `P` conformance (opaque result type).

<a id="glossary-pat"></a>
**PAT** — *Protocol with Associated Types* — protocol with associated types; cannot be used as a plain type without concretization, `any`/`some`, or type erasure as needed.

<a id="glossary-generic"></a>
**Generic** — parameterize a type or function with a placeholder type (`Array<Element>`, `func foo<T>(_: T)`).

<a id="glossary-type-erasure"></a>
**Type erasure** — wrapper (`AnySequence`, `AnyView`) hiding a concrete generic behind one protocol type for collections or public API.

<a id="glossary-pop"></a>
**POP** — *Protocol-Oriented Programming* — compose behavior via protocols and `extension` instead of deep class inheritance.

<a id="glossary-codable"></a>
**Codable** — synonym for `Encodable & Decodable`; automatic or manual mapping to/from JSON/plist.

<a id="glossary-equatable"></a>
**Equatable** — logical equality protocol (`==`); basis for tests, `contains`, value branching.

<a id="glossary-hashable"></a>
**Hashable** — extends `Equatable`: hash for `Set` elements and `Dictionary` keys; implement via `hash(into:)` — hash value is not guaranteed stable across process launches (Hasher randomization).

### UIKit

<a id="glossary-diffable-data-source"></a>
**Diffable Data Source** — API for `UICollectionView` / `UITableView` with automatic animations via snapshot diffing.

<a id="glossary-compositional-layout"></a>
**Compositional Layout** — declarative layout for `UICollectionView`: items → groups → sections.

<a id="glossary-auto-layout"></a>
**Auto Layout** — constraint system between views: position and size from constraints, not fixed frames (adapts to screen and localization).

<a id="glossary-safe-area"></a>
**Safe Area** — content region inside the screen accounting for notches, Home indicator, and keyboard; pin UI to `safeAreaLayoutGuide`.

<a id="glossary-uiviewcontroller-lifecycle"></a>
**UIViewController lifecycle** — chain `loadView` → `viewDidLoad` → `viewWillAppear` → `viewDidAppear` → …; hooks for loading data and subscribing to notifications.

<a id="glossary-intrinsic-content-size"></a>
**Intrinsic Content Size** — view’s natural size from content; affects constraint resolution without explicit width/height.

<a id="glossary-runloop"></a>
**RunLoop** — thread event loop (on main: gestures, timers, input sources); long synchronous work on main blocks UI responsiveness.

<a id="glossary-kvo"></a>
**KVO** — *Key-Value Observing* — notifications when a property changes via key-path; in Swift requires `@objc` and `dynamic` (or NSObject subclasses); remove observation carefully to avoid dangling references.

### SwiftUI

<a id="glossary-state"></a>
**@State** — stores value-type state owned by the view; updates `body` on change.

<a id="glossary-binding"></a>
**@Binding** — two-way link to parent state (`$foo`); does not own the value.

<a id="glossary-observable"></a>
**@Observable** — (Swift 5.9+) observable model macro; fine-grained view updates on field changes without manual `objectWillChange`.

<a id="glossary-viewbuilder"></a>
**ViewBuilder** — `@resultBuilder` for nested view DSL in `body` and modifiers.

### Swift syntax / DSL

<a id="glossary-optional"></a>
**Optional** — enum with `.some(Wrapped)` and `.none`; `?` and `!` suffixes are Optional sugar.

<a id="glossary-optional-chaining"></a>
**Optional chaining** — access chain via `?.`: if any link is `nil`, the whole chain is `nil` and right-hand expressions are not evaluated (*short-circuit*); result type stays Optional.

<a id="glossary-nil-coalescing-operator"></a>
**Nil-coalescing operator** — binary `??`: if the left side is not `.none`, returns the unwrapped value; otherwise evaluates and returns the right operand (right side is **not** evaluated when left has a value).

<a id="glossary-implicitly-unwrapped-optional"></a>
**Implicitly unwrapped optional** — *IUO* — type `Wrapped!`; same as `Optional<Wrapped>`, but the compiler allows access to `Wrapped` without explicit `?`/`!`; `.none` access causes a runtime error; use only where “value exists before use” is truly guaranteed (often `@IBOutlet`, initialization phases).

<a id="glossary-pattern-matching"></a>
**Pattern matching** — match a value to a **pattern**: `switch` / `if case` / `guard case` / `for case`, extract enum associated values, unpack tuples, `where` conditions; basis of expressive branching in Swift.

<a id="glossary-swift-operators-overview"></a>
**Swift operators (overview)** — ternary `? :`; **nil-coalescing** `??` and **optional chaining** `?.` in separate entries; arithmetic `+ - * / %`, comparison `== != < > <= >=`, logic `&& || !`, assignment `=` and compound `+=` … `>>=`; ranges `...` `..<` (including one-sided); overflow `&+ &- &* &/ &%`; reference identity `=== !==`; casting `is` `as` `as?` `as!`; closure operator `{ }`; custom operators via `operator` (`prefix` / `infix` / `postfix`) with precedence and associativity.

<a id="glossary-capture-list"></a>
**Capture list** — in a closure `{ [weak self] in … }` explicit capture list; default is strong references and retain-cycle risk.

<a id="glossary-concatenation"></a>
**Concatenation** — joining data into one whole; most often used for string joining.

<a id="glossary-escaping"></a>
**@escaping** — closure that may be called after the function returns (e.g. `URLSession` callback); capture `self` deliberately (`weak`/`unowned` when needed).

<a id="glossary-guard"></a>
**guard** — early exit from a function; straightens the “happy path”.

<a id="glossary-defer"></a>
**defer** — block run on **any** exit from the current scope (reverse order with multiple `defer`) — handy for symmetric cleanup.

<a id="glossary-throws-rethrows"></a>
**throws / rethrows** — `throws`: function may end with `Error`; `rethrows`: propagates error only if the passed closure throws.

<a id="glossary-inout"></a>
**inout** — parameter passed by reference for mutation inside the function and visible outside after return.

<a id="glossary-property-wrapper"></a>
**Property wrapper** — syntax `@Wrapper var x`: compiler generates storage and access via the wrapper type (`@State`, `@Published`, …).

<a id="glossary-result-builder"></a>
**Result Builder** — declarative syntax “like SwiftUI `body`”; built via `@resultBuilder`.

### Network and storage

<a id="glossary-urlsession"></a>
**URLSession** — HTTP(S) API: `data(for:)`, upload/download tasks, configurations and cache; typical REST client foundation.

<a id="glossary-rest"></a>
**REST** · *Backend · Networking*

Стиль HTTP API: ресурсы, глаголы методов, коды статуса. Это соглашение, не отдельный протокол. Related: [URLSession](#glossary-urlsession), [JSON](#glossary-json).

<a id="glossary-json"></a>
**JSON** — text data interchange format; in Swift usually parsed via `Codable`.

<a id="glossary-keychain"></a>
**Keychain** — secret storage isolated from the app and protected by the system (encryption, access policies).

<a id="glossary-ats"></a>
**ATS** — *App Transport Security* — platform policy: by default requires secure transport (HTTPS, modern TLS, limits on exceptions).

<a id="glossary-certificate-pinning"></a>
**Certificate pinning** — client verifies server certificate or public key against an embedded fingerprint (pin), not only the system trust store; hardens against MITM if a CA is compromised, but complicates certificate rotation.

### Metrics, diagnostics, and tests

<a id="glossary-metrickit"></a>
**MetricKit** — framework for stability and performance metrics from real devices (field diagnostics).

<a id="glossary-instruments"></a>
**Instruments** — Xcode profiler suite: CPU, memory, network, energy, SwiftUI; find bottlenecks and leaks.

<a id="glossary-mcp"></a>
**MCP** — *Model Context Protocol* — open protocol connecting AI assistants to external tools and data. Full card: [AI Dictionary · MCP](../ai-engineering/dictionary/terms/mcp.md).

<a id="glossary-unit-test"></a>
**Unit test** — isolated logic (models, services) with mocks/stubs; no manual UI.

<a id="glossary-ui-test"></a>
**UI test** — XCTest scenarios over the accessibility tree on simulator or device: end-to-end user flows.

### Build and project architecture

<a id="glossary-spm"></a>
**SPM** — *Swift Package Manager* — Apple’s package and dependency manager.

<a id="glossary-tuist"></a>
**Tuist** — generates Xcode projects from Swift descriptions (modules, targets, consistent structure).

<a id="glossary-tca"></a>
**TCA** — *The Composable Architecture* (Point-Free) — **Reducer / State / Action** model for composing logic, often with SwiftUI.

<a id="glossary-dsym"></a>
**dSYM** — debug symbols mapping crash log addresses to source lines (including TestFlight/App Store Connect).

<a id="glossary-ci-cd"></a>
**CI/CD** — continuous integration and delivery: automated builds, tests, and artifact deployment via pipeline.

<a id="glossary-app-thinning"></a>
**App Thinning** — App Store delivers a “slim” build: only the **binary slice** for the device architecture and matching resource variants by idiom/scale; reduces download size (optionally with *On-Demand Resources*).

### Processes and documents

<a id="glossary-rfc"></a>
**RFC** — *Request For Comments* — document proposing a technical change (including Swift Evolution).

<a id="glossary-adr"></a>
**ADR** — *Architecture Decision Record* — short record of an architecture decision with context and consequences.

