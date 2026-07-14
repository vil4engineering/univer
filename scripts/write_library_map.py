#!/usr/bin/env python3
"""Regenerate campus/library/README.md from TOPIC_TREE. Does not touch _sidebar.md."""

from pathlib import Path

from topic_tree import TOPIC_TREE

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "campus" / "library" / "README.md"


def topic_url(section: str, slug: str) -> str:
    if section == "glossary" and slug == ".":
        return "../../glossary/"
    if section == "reference" and slug == "curated":
        return "../../reference/curated/"
    return f"../../{section}/{slug}/"


def path_label(section: str, slug: str) -> str:
    if section == "glossary" and slug == ".":
        return "glossary/"
    if section == "reference" and slug == "curated":
        return "reference/curated/"
    return f"{section}/{slug}/"


def main() -> None:
    lines = [
        "# Library (warehouse catalog)",
        "",
        "Full inventory of topic storage. Campus Paths / Faculties point here.",
        "Docsify sidebar stays Campus-first — this page is the searchable map.",
        "",
        "Source of truth: `scripts/topic_tree.py`. Sync check: `python3 scripts/check_library_sync.py`.",
        "Regenerate this page: `python3 scripts/write_library_map.py`.",
        "",
        "Language: new and Path-touched pages follow [LANGUAGE.md](../LANGUAGE.md).",
        "Many warehouse pages are still EN-heavy (language debt) until rewritten on the Path.",
        "",
    ]
    for section_slug, section in TOPIC_TREE.items():
        lines.append(f"## {section['title']}")
        lines.append("")
        for topic_slug, title in section["topics"].items():
            lines.append(
                f"- [{title}]({topic_url(section_slug, topic_slug)}) — `{path_label(section_slug, topic_slug)}`"
            )
        lines.append("")
    OUT.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")
    print(f"wrote {OUT.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
