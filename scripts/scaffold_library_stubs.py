#!/usr/bin/env python3
"""Create missing Library README stubs from TOPIC_TREE. Never writes _sidebar.md."""

from pathlib import Path

from topic_tree import STUB_TEMPLATE, TOPIC_TREE

ROOT = Path(__file__).resolve().parents[1]
SKIP = {ROOT / "reference" / "curated" / "README.md"}


def readme_path(section: str, slug: str) -> Path:
    if section == "glossary" and slug == ".":
        return ROOT / "glossary" / "README.md"
    return ROOT / section / slug / "README.md"


def main() -> None:
    for section_slug, section in TOPIC_TREE.items():
        for topic_slug, title in section["topics"].items():
            path = readme_path(section_slug, topic_slug)
            if path in SKIP:
                continue
            path.parent.mkdir(parents=True, exist_ok=True)
            if not path.exists():
                path.write_text(STUB_TEMPLATE.format(title=title), encoding="utf-8")
                print(f"stub {path.relative_to(ROOT)}")
    print("scaffold done (sidebar untouched)")


if __name__ == "__main__":
    main()
