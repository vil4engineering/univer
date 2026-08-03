# Mastering Git — developer mental model (LinkedIn)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `505030` |
| Related | devops / git |
| URL | https://www.linkedin.com/posts/narendra-k-2402b4202_developers-git-backend-share-7480824611551633408-Wk57/ |

---

## Выжимка (Narendra K.)

Большинство разработчиков каждый день пользуются Git и всё равно не понимают, что происходит под капотом.

Проблема не в сложности команд — они простые. Не хватает **mental model**: как данные движутся между четырьмя стадиями:

**Working Directory → Staging Area → Local Repo → Remote Repo**

Когда видишь Git как pipeline, а не список команд, всё складывается.

**Working Directory → Staging Area**

- `git add` — переносит конкретные untracked/modified изменения в index
- `git add .` — stage всего в текущей директории
- `git commit -a -m "message"` — пропускает staging и коммитит все tracked изменения напрямую

**Staging Area → Local Repo**

- `git commit -m "message"` — фиксирует staged изменения в history с сообщением
- `git commit --amend` — правит последний commit вместо нового

**Local Repo → Remote Repo**

- `git push` — отправляет commits на remote branch
- `git push -u origin` — push + upstream tracking branch
- `git push --force` — перезаписывает remote history локальной веткой (осторожно)

**Remote Repo → Local**

- `git fetch` — скачивает изменения с remote без merge
- `git pull` — fetch + merge за один шаг
- `git merge` — объединяет fetched изменения в текущую ветку
- `git rebase` — перепроигрывает твои commits поверх history другой ветки

**Checking what changed**

- `git status` — состояние working directory и staging area
- `git diff` — unstaged изменения
- `git diff --staged` / `--cached` — staged vs последний commit
- `git diff HEAD` — working directory vs последний commit
- `git log` / `git log --oneline --graph` — history и компактное дерево

**Undoing mistakes**

- `git reset` — unstage без потери изменений
- `git reset --hard` — сброс всех local изменений
- `git checkout --` — откат файла к последнему commit
- `git revert` — новый commit, отменяющий предыдущий
- `git stash` — временно убирает uncommitted изменения

**Branching**

- `git branch` — список локальных веток
- `git checkout -b` / `git switch` — создать или переключиться

Когда понимаешь этот flow, перестаёшь бояться Git и начинаешь пользоваться осознанно.

## Соседний пост

Также в Saved: Jaswindder «50 commands in 5 words» — listicle-шпаргалка; ниже durability, чем mental-model framing.

## Useful?

Promote durable mental-model bits в fundamentals/devops git note позже; listicle оставь как pointer only.
