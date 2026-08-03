#!/usr/bin/env python3
"""Library warehouse catalog — source of truth for topic inventory (not Docsify sidebar)."""

TOPIC_TREE = {
    "fundamentals": {
        "title": "Fundamentals",
        "topics": {
            "what-is-programming": "What Is Programming?",
            "computer-science": "Computer Science",
            "os-and-networks": "OS & Networks",
            "git": "Git & Code Review",
            "cli": "CLI & Terminal",
            "development-principles": "Development Principles",
        },
    },
    "swift": {
        "title": "Swift",
        "topics": {
            "what-is-swift": "Why Swift Exists",
            "syntax": "Syntax & Idioms",
            "protocols": "Protocols",
            "types-generics": "Types & Generics",
            "method-dispatch": "Method Dispatch",
            "memory-arc": "Memory & ARC",
            "concurrency": "Concurrency",
            "async-defer": "Async cleanup with defer",
            "metaprogramming": "Metaprogramming",
        },
    },
    "ios-sdk": {
        "title": "iOS SDK",
        "topics": {
            "foundation": "Foundation & Lifecycle",
            "format-style": "FormatStyle & Parsing",
            "uikit": "UIKit",
            "swiftui": "SwiftUI",
            "app-intents": "App Intents",
            "auto-layout": "Auto Layout",
            "collection-views": "Collection Views",
            "animations": "Animations",
            "graphics": "Graphics & Metal",
            "core-bluetooth": "Core Bluetooth & BLE",
        },
    },
    "architecture": {
        "title": "Architecture",
        "topics": {
            "patterns": "MVVM → TCA",
            "navigation": "Navigation & Deep Links",
            "modularization": "Modularization",
        },
    },
    "system-design": {
        "title": "System Design",
        "topics": {
            "mobile": "Mobile App Design",
            "bdui": "Backend-Driven UI",
            "offline-first": "Offline First",
            "sync-engine": "Sync Engine",
            "push-notifications": "Push Notifications",
            "deep-links": "Deep Links",
            "feature-flags": "Feature Flags",
            "analytics": "Analytics & Remote Config",
            "scaling-teams": "Scaling Teams",
        },
    },
    "data-and-network": {
        "title": "Data & Network",
        "topics": {
            "networking": "Networking",
            "storage": "Storage & Persistence",
            "caching-offline-first": "Caching & Offline-First",
        },
    },
    "quality": {
        "title": "Quality",
        "topics": {
            "testing": "Testing",
            "debug": "Debug & Instruments",
            "performance": "Performance",
            "security": "Security",
            "accessibility": "Accessibility & Localization",
        },
    },
    "devops": {
        "title": "DevOps",
        "topics": {
            "ci-cd": "CI/CD",
            "app-store": "App Store & TestFlight",
            "monitoring": "Crash Analytics & Monitoring",
        },
    },
    "algorithms": {
        "title": "Algorithms",
        "topics": {
            "structures": "Data Structures & Big-O",
            "design-patterns": "Design Patterns",
        },
    },
    "ai-engineering": {
        "title": "AI Engineering",
        "topics": {
            "dictionary": "AI Dictionary",
            "roadmap": "Roadmap",
            "llm-basics": "01 · LLM Basics",
            "tokens": "02 · Tokens",
            "context-window": "03 · Context Window",
            "embeddings": "04 · Embeddings",
            "vector-search": "05 · Vector Search",
            "rag": "06 · RAG",
            "structured-output": "07 · Structured Output",
            "tool-calling": "08 · Tool Calling",
            "agents": "09 · Agents",
            "agent-patterns": "Agent Patterns",
            "mcp": "10 · MCP",
            "foundation-models": "11 · Foundation Models",
            "apple-intelligence": "12 · Apple Intelligence",
            "dynamic-profiles": "13 · Dynamic Profiles",
            "evaluations": "14 · Evaluations",
            "materials": "Accompanying materials",
        },
    },
    "reference": {
        "title": "Curated",
        "topics": {
            "curated": "External Links",
        },
    },
    "glossary": {
        "title": "Reference",
        "topics": {
            ".": "Glossary",
        },
    },
}

STUB_TEMPLATE = """# {title}

> **Status:** draft — content pending · language debt until Path rewrite (RU-primary)

## In 30 seconds

_(Summary — to be added)_

## Key concepts

_(to be added)_

## How to answer in interviews

_(to be added)_

## Code & examples

_(to be added)_

## Links

_(to be added)_
"""

DRAFT_MARKER = "> **Status:** draft"
