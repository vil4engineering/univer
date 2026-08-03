# Divide app into modules — faster builds (Jacob Bartlett)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | yes |
| Source | Telegram Saved `507903` |
| Related | [Modularization README](../README.md) |
| URL | https://blog.jacobstechtavern.com/p/modular-ios-architecture · https://jacobbartlett.substack.com/p/modular-architecture-for-apps |

---

## In 30 seconds

Modularization limits how much of the dependency graph recompiles after a change: clearer feature/service boundaries, parallel compile, better Xcode caches. Core module first → feature modules; at scale still hit base-layer invalidation → consider Bazel/Buck. Feature API vs Impl (Tuist-style) keeps dependents stable when impl changes.

## LinkedIn

Original Saved short link 404’d as post page; substance matches Bartlett’s modular architecture posts on build times.

## Try apply

Compare with [spm-common-services-features-cheatsheet](spm-common-services-features-cheatsheet.md) and JET five-category note.
