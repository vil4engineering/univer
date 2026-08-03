# Mastering Git — developer mental model (LinkedIn)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `505030` |
| Related | devops / git |
| URL | https://www.linkedin.com/posts/narendra-k-2402b4202_developers-git-backend-share-7480824611551633408-Wk57/ |

---

## Digest (Narendra K.)

Most #developers use #Git daily and still don't understand what's actually happening under the hood.

Here's the problem →
Git isn't hard. The commands are simple. 

What's missing is the mental model of how data actually moves between the four stages:
Working Directory → Staging Area → Local Repo → Remote Repo

Once you see Git as a pipeline instead of a list of commands, everything clicks.

𝗪𝗼𝗿𝗸𝗶𝗻𝗴 𝗗𝗶𝗿𝗲𝗰𝘁𝗼𝗿𝘆 → 𝗦𝘁𝗮𝗴𝗶𝗻𝗴 𝗔𝗿𝗲𝗮
→ git add  — moves specific untracked/modified changes into the index
→ git add . — stages everything in the current directory
→ git commit -a -m "message" — skips staging and commits all tracked changes directly

𝗦𝘁𝗮𝗴𝗶𝗻𝗴 𝗔𝗿𝗲𝗮 → 𝗟𝗼𝗰𝗮𝗹 𝗥𝗲𝗽𝗼
→ git commit -m "message" — locks your staged changes into history with a message
→ git commit --amend — edits the last commit instead of creating a new one

𝗟𝗼𝗰𝗮𝗹 𝗥𝗲𝗽𝗼 → 𝗥𝗲𝗺𝗼𝘁𝗲 𝗥𝗲𝗽𝗼
→ git push — sends your commits upstream to the remote branch
→ git push -u origin  — pushes and sets the upstream tracking branch
→ git push --force — overwrites remote history with your local branch (use with caution)

𝗥𝗲𝗺𝗼𝘁𝗲 𝗥𝗲𝗽𝗼 → 𝗟𝗼𝗰𝗮𝗹
→ git fetch — downloads changes from remote without merging them
→ git pull — fetches and merges remote changes in one step
→ git merge  — combines the fetched changes into your current branch
→ git rebase  — replays your commits on top of another branch's history for a cleaner log

𝗖𝗵𝗲𝗰𝗸𝗶𝗻𝗴 𝘄𝗵𝗮𝘁 𝗰𝗵𝗮𝗻𝗴𝗲𝗱
→ git status — shows the current state of working directory and staging area
→ git diff — shows unstaged changes in the working directory
→ git diff --staged / --cached — shows staged changes compared to the last commit
→ git diff HEAD — compares working directory to the last commit
→ git diff  — compares any two points in history
→ git log — shows commit history
→ git log --oneline --graph — shows a compact, visual commit tree

𝗨𝗻𝗱𝗼𝗶𝗻𝗴 𝗺𝗶𝘀𝘁𝗮𝗸𝗲𝘀
→ git reset  — unstages a file without losing changes
→ git reset --hard — discards all local changes and staged files
→ git checkout --  — reverts a file back to the last commit
→ git revert  — creates a new commit that undoes a previous one safely
→ git stash — temporarily shelves uncommitted changes so you can switch context

𝗕𝗿𝗮𝗻𝗰𝗵𝗶𝗻𝗴
→ git branch — lists all local branches
→ git branch  — creates a new branch
→ git checkout -b  — creates and switches to a new branch
→ git switch  — switches to an existing branch (safer alternative to checkout)

Once you understand this flow, you stop fearing Git. You start using it with intent.

Save this. You'll need it the next time git throws an error you don't recognize.

 Comment "GIT" and I'll DM you the workflow cheat sheet.

Follow Narendra K. for daily #backend, #Java, and #interview prep content that actually makes sense. | 76 comments on LinkedIn

## Companion post

Also Saved: Jaswindder “50 commands in 5 words” listicle — command-cheatsheet style, lower durability than mental-model framing.

## Useful?

Promote durable mental-model bits into a fundamentals/devops git note later; keep listicle as pointer only.
