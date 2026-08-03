# GPT-5.6 model notes (speed / boundaries)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `504839` |
| Related | [AI materials](README.md) |

---

Да, короче, ребята и девчата. 

Не смотря на всю неоднозначность релиза 5.6 — это очень сильная и очень классная модель. Я сегодня провёл кучу времени и тестов с ней, и у меня она на более сложных задачах справляется лучше и дешевле по токенам. 

Но с ней есть ньюансы. 

1. Скорость. На скорости очень высокая и ультра, она настолько медленная, насколько возможно. Прям вот по ощущениям раза в 2-3 порой, медленнее чем 5.5 был. 

2. Границы дозволенности. Его прям уводит. Пример который я писал выше — он был не единый за сегодня. Было ещё 2-3 раза, хотя до этого такого не наблюдалось совсем. 

Если копнуть — то все эти ньюансы прямо написаны в инструкции к ней. Использовать режимы выше медиума нужно при крайней необходимости. А рабочая лошадка вооще терра, которая работает как 5.5, но экономнее. 

Но она умнее. Она точно лучше работает на границе контекста, то есть там где 5.5 уже тупил, она не тупит. Плюс он отлично визуализирует в чате. 

Ещё один минус — приложение новое. Вот тот случай когда пытались сделать тоже самое, что у клода, но не тоже самое. В итоге получилось не очень. Но уже обещали переделать. 

Советую две правки. 

В основной Agents.md 
## Prompt discipline, autonomy, and response style

This section is the single source of truth for instruction repetition, tool selection, autonomy, response length, and tone. It overrides duplicated guidance elsewhere.

### Instructions and tools

- State and apply each rule once. Do not repeat equivalent instructions.
- Apply only guidance relevant to the current task.
- Use only the tools, skills, context, and examples requ

## Docs

https://developers.openai.com/api/docs/guides/latest-model?model=gpt-5.6
