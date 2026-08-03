# iOS Performance Agent Skills (+ launch-time skill)

| Field | Value |
|-------|-------|
| Added | 2026-08-03 |
| Useful? | pending |
| Source | Telegram Saved `504997, 504996` |
| Related | [Performance](../README.md) |

---

## Repos / posts

- https://github.com/Livsy90/iOS-Performance-Agent-Skills/tree/main
- LinkedIn Artem Mirzabekian (launch time skill): https://www.linkedin.com/posts/artem-mirzabekian_im-continuing-my-series-about-ai-agent-skills-share-7482296495090806784-fBG7/

## In 30 seconds

Agent skills for reviewing/diagnosing iOS performance; launch-time skill called out as sensitive path.

## Try apply

Wire selected skills into local agent harness for Instruments-driven reviews.

## LinkedIn digest (launch-time skill)

I’m continuing my series about AI Agent Skills for iOS development.

Today, I want to share a skill focused on one of the most sensitive parts of an app’s performance: launch time.

The iOS Launch Performance skill helps an AI agent investigate startup problems without falling back on generic advice such as "move the work off the main thread" or "reduce the number of frameworks."

The skill then treats startup as a pipeline. It helps the agent identify the expensive phase, inspect the critical path, and separate work that must happen before the first frame from work that can wait until the first interaction or a later feature.

The included references cover UIKit and SwiftUI lifecycle code, pre-main work, launch orchestration, SDK startup, linking strategy, XCTest metrics, Instruments, MetricKit, and production monitoring.

The goal is to help an agent classify the problem, connect recommendations to evidence, and explain how each change should be validated.

Article: https://lnkd.in/d-WdDCTD

⭐ GitHub: https://lnkd.in/dMB9CmvT

