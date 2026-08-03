#!/usr/bin/env python3
"""Fail if disk topic folders and TOPIC_TREE disagree.

Inventory is **top-level only**: `section/topic/README.md` (e.g. `swift/concurrency`).
Nested Living chapters under a hub (e.g. `swift/concurrency/actors-and-isolation`)
are intentional and must NOT appear in TOPIC_TREE.
"""

from __future__ import annotations

import sys
from pathlib import Path

from topic_tree import TOPIC_TREE

ROOT = Path(__file__).resolve().parents[1]

WAREHOUSE_SECTIONS = [
    "fundamentals",
    "swift",
    "ios-sdk",
    "architecture",
    "system-design",
    "data-and-network",
    "quality",
    "devops",
    "algorithms",
    "ai-engineering",
]


def disk_topics() -> set[str]:
    found: set[str] = set()
    for section in WAREHOUSE_SECTIONS:
        base = ROOT / section
        if not base.is_dir():
            continue
        for child in base.iterdir():
            if child.is_dir() and (child / "README.md").exists():
                found.add(f"{section}/{child.name}")
    if (ROOT / "glossary" / "README.md").exists():
        found.add("glossary")
    if (ROOT / "reference" / "curated" / "README.md").exists():
        found.add("reference/curated")
    return found


def tree_topics() -> set[str]:
    found: set[str] = set()
    for section_slug, section in TOPIC_TREE.items():
        for topic_slug in section["topics"]:
            if section_slug == "glossary" and topic_slug == ".":
                found.add("glossary")
            elif section_slug == "reference" and topic_slug == "curated":
                found.add("reference/curated")
            else:
                found.add(f"{section_slug}/{topic_slug}")
    return found


def main() -> int:
    disk = disk_topics()
    tree = tree_topics()
    missing_in_tree = sorted(disk - tree)
    missing_on_disk = sorted(tree - disk)
    ok = not missing_in_tree and not missing_on_disk
    print(f"disk={len(disk)} tree={len(tree)}")
    if missing_in_tree:
        print("on disk but missing from TOPIC_TREE:")
        for path in missing_in_tree:
            print(f"  {path}")
    if missing_on_disk:
        print("in TOPIC_TREE but missing on disk:")
        for path in missing_on_disk:
            print(f"  {path}")
    if ok:
        print("library sync OK")
        return 0
    print("library sync FAILED")
    return 1


if __name__ == "__main__":
    sys.exit(main())
