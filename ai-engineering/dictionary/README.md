# AI Dictionary

Практический словарь современной AI engineering терминологии для software engineers.

- **Цель:** понимание для сборки AI-powered приложений, не академическая энциклопедия.
- **Язык:** RU-primary объяснения, EN-термины as-is ([LANGUAGE](../../campus/LANGUAGE.md)).
- **Сестра:** [Glossary portal](../../glossary/) — iOS/Swift + вход в этот Dictionary.

Каждый термин — отдельная страница в `terms/` (full или stub). Living document: stubs дописываются по мере работы.

---

## In 30 seconds

Когда в чате, PR или API docs встречается `RAG`, `tool calling`, `embedding`, `MCP` — открой карточку здесь: короткое определение, зачем инженеру, пример, related. Глубокие onions трека — в [AI Engineering](../README.md).

---

## How to read

| Importance | Meaning |
|------------|---------|
| **Essential** | Must-know для AI feature work |
| **Important** | Daily work при сборке пайплайнов |
| **Advanced** | Infra, training, research depth |

Status на карточке: `full` (готово) или `stub` (slug + краткое определение).

---

## Learning Path

### Level 1 — Must Know


- [AI](terms/ai.md)
- [Machine Learning](terms/machine-learning.md)
- [Deep Learning](terms/deep-learning.md)
- [Neural Network](terms/neural-network.md)
- [Model](terms/model.md)
- [Parameters](terms/parameters.md)
- [Inference](terms/inference.md)
- [Training](terms/training.md)
- [Fine-tuning](terms/fine-tuning.md)
- [LLM](terms/llm.md)
- [Context Window](terms/context-window.md)
- [Prompt](terms/prompt.md)
- [Token](terms/token.md)
- [Embedding](terms/embedding.md)
- [RAG](terms/rag.md)
- [Vector Database](terms/vector-database.md)
- [AI Agent](terms/ai-agent.md)
- [Tool Calling](terms/tool-calling.md)
- [Hallucination](terms/hallucination.md)
- [MCP](terms/mcp.md)

### Level 2 — Daily Work


- [System Prompt](terms/system-prompt.md)
- [User Prompt](terms/user-prompt.md)
- [Completion](terms/completion.md)
- [Tokenizer](terms/tokenizer.md)
- [Input Tokens](terms/input-tokens.md)
- [Output Tokens](terms/output-tokens.md)
- [Token Budget](terms/token-budget.md)
- [Token Cost](terms/token-cost.md)
- [Prompt Engineering](terms/prompt-engineering.md)
- [Zero-shot](terms/zero-shot.md)
- [Few-shot](terms/few-shot.md)
- [Structured Output](terms/structured-output.md)
- [JSON Mode](terms/json-mode.md)
- [Schema](terms/schema.md)
- [Retrieval](terms/retrieval.md)
- [Chunk](terms/chunk.md)
- [Chunking](terms/chunking.md)
- [Grounding](terms/grounding.md)
- [Semantic Search](terms/semantic-search.md)
- [Cosine Similarity](terms/cosine-similarity.md)
- [Function Calling](terms/function-calling.md)
- [Streaming](terms/streaming.md)
- [Temperature](terms/temperature.md)
- [Evaluation (Eval)](terms/evaluation.md)
- [Latency](terms/latency.md)
- [Guardrails](terms/guardrails.md)
- [Observability](terms/observability.md)
- [Chat Completion API](terms/chat-completion-api.md)
- [GPT](terms/gpt.md)
- [Claude](terms/claude.md)
- [Gemini](terms/gemini.md)

Плюс остальные Essential/Important stubs в каталоге ниже.

### Level 3 — Advanced


- [AGI](terms/agi.md)
- [Self Consistency](terms/self-consistency.md)
- [Re-ranking](terms/re-ranking.md)
- [Reflection](terms/reflection.md)
- [Context Compression](terms/context-compression.md)
- [ANN Search](terms/ann-search.md)
- [Model Registry](terms/model-registry.md)
- [Load Balancing](terms/load-balancing.md)
- [Reasoning Model](terms/reasoning-model.md)
- [Pretraining](terms/pretraining.md)
- [Benchmark](terms/benchmark.md)
- [F1](terms/f1.md)
- [FAISS](terms/faiss.md)
- [Milvus](terms/milvus.md)
- [DeepSeek](terms/deepseek.md)

---

## Catalog by category


### Fundamentals

- [AGI](terms/agi.md) — ОСИ / AGI · Advanced · `stub`
- [AI](terms/ai.md) — ИИ (искусственный интеллект) · Essential · `full`
- [Checkpoint](terms/checkpoint.md) — чекпоинт · Important · `stub`
- [Deep Learning](terms/deep-learning.md) — глубокое обучение · Essential · `full`
- [Fine-tuning](terms/fine-tuning.md) — дообучение · Essential · `full`
- [Inference](terms/inference.md) — инференс · Essential · `full`
- [Machine Learning](terms/machine-learning.md) — машинное обучение · Essential · `full`
- [Model](terms/model.md) — модель · Essential · `full`
- [Neural Network](terms/neural-network.md) — нейронная сеть · Essential · `full`
- [Parameters](terms/parameters.md) — параметры · Essential · `full`
- [Pretraining](terms/pretraining.md) — предобучение · Important · `stub`
- [Training](terms/training.md) — обучение · Essential · `full`
- [Weights](terms/weights.md) — веса · Important · `stub`

### LLM

- [Completion](terms/completion.md) — комплишн / ответ модели · Important · `stub`
- [Context Window](terms/context-window.md) — контекстное окно · Essential · `full`
- [Embedding Model](terms/embedding-model.md) — embedding-модель · Essential · `stub`
- [LLM](terms/llm.md) — большая языковая модель (Large Language Model) · Essential · `full`
- [Multimodal](terms/multimodal.md) — мультимодальность · Important · `stub`
- [Prompt](terms/prompt.md) — промпт · Essential · `full`
- [Reasoning Model](terms/reasoning-model.md) — reasoning-модель · Important · `stub`
- [System Prompt](terms/system-prompt.md) — системный промпт · Important · `stub`
- [User Prompt](terms/user-prompt.md) — пользовательский промпт · Important · `stub`
- [Vision Model](terms/vision-model.md) — vision-модель · Important · `stub`

### Tokens

- [Input Tokens](terms/input-tokens.md) — входные токены · Important · `stub`
- [Output Tokens](terms/output-tokens.md) — выходные токены · Important · `stub`
- [Token](terms/token.md) — токен · Essential · `full`
- [Token Budget](terms/token-budget.md) — бюджет токенов · Important · `stub`
- [Token Cost](terms/token-cost.md) — стоимость токенов · Important · `stub`
- [Tokenizer](terms/tokenizer.md) — токенизатор · Important · `stub`

### Prompt Engineering

- [Chain of Thought (CoT)](terms/chain-of-thought.md) — цепочка рассуждений · Important · `stub`
- [Few-shot](terms/few-shot.md) — few-shot · Important · `stub`
- [JSON Mode](terms/json-mode.md) — JSON mode · Important · `stub`
- [One-shot](terms/one-shot.md) — one-shot · Important · `stub`
- [Prompt Engineering](terms/prompt-engineering.md) — промпт-инжиниринг · Essential · `stub`
- [Schema](terms/schema.md) — схема · Important · `stub`
- [Self Consistency](terms/self-consistency.md) — self-consistency · Advanced · `stub`
- [Structured Output](terms/structured-output.md) — структурированный вывод · Essential · `stub`
- [Zero-shot](terms/zero-shot.md) — zero-shot · Important · `stub`

### Retrieval (RAG)

- [Chunk](terms/chunk.md) — чанк · Essential · `stub`
- [Chunking](terms/chunking.md) — чанкинг · Essential · `stub`
- [Grounding](terms/grounding.md) — заземление ответа · Essential · `stub`
- [Knowledge Base](terms/knowledge-base.md) — база знаний · Important · `stub`
- [RAG](terms/rag.md) — retrieval-augmented generation · Essential · `full`
- [Re-ranking](terms/re-ranking.md) — реранкинг · Important · `stub`
- [Retrieval](terms/retrieval.md) — извлечение · Essential · `stub`
- [Retriever](terms/retriever.md) — ретривер · Important · `stub`

### Embeddings

- [ANN Search](terms/ann-search.md) — приближённый ближайший сосед · Important · `stub`
- [Chroma](terms/chroma.md) — Chroma · Important · `stub`
- [Cosine Similarity](terms/cosine-similarity.md) — косинусное сходство · Important · `stub`
- [Embedding](terms/embedding.md) — эмбеддинг · Essential · `full`
- [Embedding Space](terms/embedding-space.md) — пространство эмбеддингов · Important · `stub`
- [FAISS](terms/faiss.md) — FAISS · Important · `stub`
- [Milvus](terms/milvus.md) — Milvus · Important · `stub`
- [Pinecone](terms/pinecone.md) — Pinecone · Important · `stub`
- [Qdrant](terms/qdrant.md) — Qdrant · Important · `stub`
- [Semantic Search](terms/semantic-search.md) — семантический поиск · Essential · `stub`
- [Similarity](terms/similarity.md) — сходство · Important · `stub`
- [Vector](terms/vector.md) — вектор · Essential · `stub`
- [Vector Database](terms/vector-database.md) — векторная база данных · Essential · `full`
- [Weaviate](terms/weaviate.md) — Weaviate · Important · `stub`

### Agents

- [AI Agent](terms/ai-agent.md) — ИИ-агент · Essential · `full`
- [Executor](terms/executor.md) — исполнитель · Important · `stub`
- [Function Calling](terms/function-calling.md) — function calling · Essential · `stub`
- [MCP](terms/mcp.md) — Model Context Protocol · Essential · `full`
- [Memory](terms/memory.md) — память агента · Important · `stub`
- [Planner](terms/planner.md) — планировщик · Important · `stub`
- [Reflection](terms/reflection.md) — рефлексия · Advanced · `stub`
- [Tool Calling](terms/tool-calling.md) — вызов инструментов · Essential · `full`
- [Workflow](terms/workflow.md) — воркфлоу · Important · `stub`

### Context & Memory

- [Context](terms/context.md) — контекст · Essential · `stub`
- [Context Compression](terms/context-compression.md) — сжатие контекста · Advanced · `stub`
- [Conversation History](terms/conversation-history.md) — история диалога · Important · `stub`
- [Long-term Memory](terms/long-term-memory.md) — долговременная память · Important · `stub`
- [Session](terms/session.md) — сессия · Important · `stub`
- [Short-term Memory](terms/short-term-memory.md) — кратковременная память · Important · `stub`

### Generation

- [Deterministic Output](terms/deterministic-output.md) — детерминированный вывод · Important · `stub`
- [Sampling](terms/sampling.md) — сэмплинг · Important · `stub`
- [Streaming](terms/streaming.md) — стриминг · Essential · `stub`
- [Temperature](terms/temperature.md) — температура · Essential · `stub`
- [Top-k](terms/top-k.md) — top-k · Important · `stub`
- [Top-p](terms/top-p.md) — nucleus sampling · Important · `stub`

### Evaluation

- [Accuracy](terms/accuracy.md) — accuracy · Important · `stub`
- [Benchmark](terms/benchmark.md) — бенчмарк · Important · `stub`
- [Evaluation (Eval)](terms/evaluation.md) — оценка качества · Essential · `stub`
- [F1](terms/f1.md) — F1 · Important · `stub`
- [Ground Truth](terms/ground-truth.md) — эталон · Important · `stub`
- [Hallucination](terms/hallucination.md) — галлюцинация · Essential · `full`
- [Latency](terms/latency.md) — латентность · Essential · `stub`
- [Precision](terms/precision.md) — precision · Important · `stub`
- [Recall](terms/recall.md) — recall · Important · `stub`
- [Throughput](terms/throughput.md) — пропускная способность · Important · `stub`

### AI Infrastructure

- [Caching](terms/caching.md) — кэширование · Important · `stub`
- [Guardrails](terms/guardrails.md) — гардрейлы · Essential · `stub`
- [Inference Server](terms/inference-server.md) — inference-сервер · Important · `stub`
- [Load Balancing](terms/load-balancing.md) — балансировка нагрузки · Advanced · `stub`
- [Model Registry](terms/model-registry.md) — реестр моделей · Advanced · `stub`
- [Observability](terms/observability.md) — наблюдаемость · Essential · `stub`
- [Orchestration](terms/orchestration.md) — оркестрация · Important · `stub`
- [Pipeline](terms/pipeline.md) — пайплайн · Important · `stub`
- [Rate Limiting](terms/rate-limiting.md) — рейт-лимиты · Important · `stub`
- [Serving](terms/serving.md) — сервинг · Important · `stub`

### APIs

- [Chat Completion API](terms/chat-completion-api.md) — Chat Completions API · Essential · `stub`
- [File Search](terms/file-search.md) — поиск по файлам · Important · `stub`
- [Image Generation](terms/image-generation.md) — генерация изображений · Important · `stub`
- [Responses API](terms/responses-api.md) — Responses API · Important · `stub`
- [Speech-to-Text](terms/speech-to-text.md) — речь → текст · Important · `stub`
- [Structured Outputs](terms/structured-outputs-api.md) — Structured Outputs (API) · Important · `stub`
- [Text-to-Speech](terms/text-to-speech.md) — текст → речь · Important · `stub`
- [Web Search](terms/web-search.md) — веб-поиск (tool) · Important · `stub`

### Open Models

- [Claude](terms/claude.md) — Claude · Essential · `stub`
- [DeepSeek](terms/deepseek.md) — DeepSeek · Important · `stub`
- [Gemini](terms/gemini.md) — Gemini · Essential · `stub`
- [Gemma](terms/gemma.md) — Gemma · Important · `stub`
- [GPT](terms/gpt.md) — GPT · Essential · `stub`
- [Llama](terms/llama.md) — Llama · Important · `stub`
- [Mistral](terms/mistral.md) — Mistral · Important · `stub`
- [Qwen](terms/qwen.md) — Qwen · Important · `stub`

---

## A–Z


- [Accuracy](terms/accuracy.md)
- [AGI](terms/agi.md)
- [AI](terms/ai.md)
- [AI Agent](terms/ai-agent.md)
- [ANN Search](terms/ann-search.md)
- [Benchmark](terms/benchmark.md)
- [Caching](terms/caching.md)
- [Chain of Thought (CoT)](terms/chain-of-thought.md)
- [Chat Completion API](terms/chat-completion-api.md)
- [Checkpoint](terms/checkpoint.md)
- [Chroma](terms/chroma.md)
- [Chunk](terms/chunk.md)
- [Chunking](terms/chunking.md)
- [Claude](terms/claude.md)
- [Completion](terms/completion.md)
- [Context](terms/context.md)
- [Context Compression](terms/context-compression.md)
- [Context Window](terms/context-window.md)
- [Conversation History](terms/conversation-history.md)
- [Cosine Similarity](terms/cosine-similarity.md)
- [Deep Learning](terms/deep-learning.md)
- [DeepSeek](terms/deepseek.md)
- [Deterministic Output](terms/deterministic-output.md)
- [Embedding](terms/embedding.md)
- [Embedding Model](terms/embedding-model.md)
- [Embedding Space](terms/embedding-space.md)
- [Evaluation (Eval)](terms/evaluation.md)
- [Executor](terms/executor.md)
- [F1](terms/f1.md)
- [FAISS](terms/faiss.md)
- [Few-shot](terms/few-shot.md)
- [File Search](terms/file-search.md)
- [Fine-tuning](terms/fine-tuning.md)
- [Function Calling](terms/function-calling.md)
- [Gemini](terms/gemini.md)
- [Gemma](terms/gemma.md)
- [GPT](terms/gpt.md)
- [Ground Truth](terms/ground-truth.md)
- [Grounding](terms/grounding.md)
- [Guardrails](terms/guardrails.md)
- [Hallucination](terms/hallucination.md)
- [Image Generation](terms/image-generation.md)
- [Inference](terms/inference.md)
- [Inference Server](terms/inference-server.md)
- [Input Tokens](terms/input-tokens.md)
- [JSON Mode](terms/json-mode.md)
- [Knowledge Base](terms/knowledge-base.md)
- [Latency](terms/latency.md)
- [Llama](terms/llama.md)
- [LLM](terms/llm.md)
- [Load Balancing](terms/load-balancing.md)
- [Long-term Memory](terms/long-term-memory.md)
- [Machine Learning](terms/machine-learning.md)
- [MCP](terms/mcp.md)
- [Memory](terms/memory.md)
- [Milvus](terms/milvus.md)
- [Mistral](terms/mistral.md)
- [Model](terms/model.md)
- [Model Registry](terms/model-registry.md)
- [Multimodal](terms/multimodal.md)
- [Neural Network](terms/neural-network.md)
- [Observability](terms/observability.md)
- [One-shot](terms/one-shot.md)
- [Orchestration](terms/orchestration.md)
- [Output Tokens](terms/output-tokens.md)
- [Parameters](terms/parameters.md)
- [Pinecone](terms/pinecone.md)
- [Pipeline](terms/pipeline.md)
- [Planner](terms/planner.md)
- [Precision](terms/precision.md)
- [Pretraining](terms/pretraining.md)
- [Prompt](terms/prompt.md)
- [Prompt Engineering](terms/prompt-engineering.md)
- [Qdrant](terms/qdrant.md)
- [Qwen](terms/qwen.md)
- [RAG](terms/rag.md)
- [Rate Limiting](terms/rate-limiting.md)
- [Re-ranking](terms/re-ranking.md)
- [Reasoning Model](terms/reasoning-model.md)
- [Recall](terms/recall.md)
- [Reflection](terms/reflection.md)
- [Responses API](terms/responses-api.md)
- [Retrieval](terms/retrieval.md)
- [Retriever](terms/retriever.md)
- [Sampling](terms/sampling.md)
- [Schema](terms/schema.md)
- [Self Consistency](terms/self-consistency.md)
- [Semantic Search](terms/semantic-search.md)
- [Serving](terms/serving.md)
- [Session](terms/session.md)
- [Short-term Memory](terms/short-term-memory.md)
- [Similarity](terms/similarity.md)
- [Speech-to-Text](terms/speech-to-text.md)
- [Streaming](terms/streaming.md)
- [Structured Output](terms/structured-output.md)
- [Structured Outputs](terms/structured-outputs-api.md)
- [System Prompt](terms/system-prompt.md)
- [Temperature](terms/temperature.md)
- [Text-to-Speech](terms/text-to-speech.md)
- [Throughput](terms/throughput.md)
- [Token](terms/token.md)
- [Token Budget](terms/token-budget.md)
- [Token Cost](terms/token-cost.md)
- [Tokenizer](terms/tokenizer.md)
- [Tool Calling](terms/tool-calling.md)
- [Top-k](terms/top-k.md)
- [Top-p](terms/top-p.md)
- [Training](terms/training.md)
- [User Prompt](terms/user-prompt.md)
- [Vector](terms/vector.md)
- [Vector Database](terms/vector-database.md)
- [Vision Model](terms/vision-model.md)
- [Weaviate](terms/weaviate.md)
- [Web Search](terms/web-search.md)
- [Weights](terms/weights.md)
- [Workflow](terms/workflow.md)
- [Zero-shot](terms/zero-shot.md)

---

## Links

- [Glossary portal](../../glossary/) — iOS/Swift + domains
- [AI Engineering track](../README.md) — numbered topics 01–14
- [Faculty: AI Technology](../../campus/faculties/ai-technology.md)

