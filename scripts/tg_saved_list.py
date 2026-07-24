#!/usr/bin/env python3
from __future__ import annotations

import argparse
import asyncio
import json
import os
import re
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

URL_RE = re.compile(r"https?://[^\s<>\"']+")
ROOT = Path(__file__).resolve().parents[1]
ENV_PATH = ROOT / ".env"


def _load_dotenv(path: Path) -> None:
    if not path.is_file():
        return
    for line in path.read_text(encoding="utf-8").splitlines():
        raw = line.strip()
        if not raw or raw.startswith("#") or "=" not in raw:
            continue
        key, value = raw.split("=", 1)
        key = key.strip()
        value = value.strip().strip("'").strip('"')
        if key and key not in os.environ:
            os.environ[key] = value


def _env(name: str) -> str:
    return os.environ.get(name, "").strip()


def _require_credentials() -> tuple[int, str, str]:
    api_id_raw = _env("TELEGRAM_API_ID")
    api_hash = _env("TELEGRAM_API_HASH")
    session = _env("TELEGRAM_SESSION")
    if not api_id_raw or not api_hash or not session:
        print(
            "Need env: TELEGRAM_API_ID, TELEGRAM_API_HASH, TELEGRAM_SESSION\n"
            "(same secrets as vil4max/ios-hunter)",
            file=sys.stderr,
        )
        raise SystemExit(2)
    return int(api_id_raw), api_hash, session


def _message_text(message: Any) -> str:
    text = (getattr(message, "message", None) or "").strip()
    if not text and getattr(message, "raw_text", None):
        text = str(message.raw_text).strip()
    return text


def _message_kind(message: Any) -> str:
    if getattr(message, "web_preview", None) or getattr(message, "media", None):
        urls = URL_RE.findall(_message_text(message))
        joined = " ".join(urls).lower()
        if "youtube.com" in joined or "youtu.be" in joined:
            return "youtube"
        if "linkedin.com" in joined:
            return "linkedin"
        if urls:
            return "link"
        if getattr(message, "photo", None):
            return "photo"
        if getattr(message, "document", None):
            return "document"
        return "media"
    if URL_RE.search(_message_text(message)):
        urls = URL_RE.findall(_message_text(message))
        joined = " ".join(urls).lower()
        if "youtube.com" in joined or "youtu.be" in joined:
            return "youtube"
        if "linkedin.com" in joined:
            return "linkedin"
        return "link"
    return "text"


def _serialize(message: Any) -> dict[str, Any]:
    text = _message_text(message)
    urls = URL_RE.findall(text)
    date = getattr(message, "date", None)
    if isinstance(date, datetime):
        if date.tzinfo is None:
            date = date.replace(tzinfo=timezone.utc)
        date_iso = date.isoformat()
    else:
        date_iso = None
    preview = " ".join(text.split())
    if len(preview) > 280:
        preview = preview[:277] + "..."
    return {
        "id": int(message.id),
        "date": date_iso,
        "kind": _message_kind(message),
        "urls": urls,
        "preview": preview,
        "text": text,
    }


async def _fetch(limit: int, oldest: bool) -> list[dict[str, Any]]:
    from telethon import TelegramClient
    from telethon.sessions import StringSession

    api_id, api_hash, session = _require_credentials()
    items: list[dict[str, Any]] = []
    async with TelegramClient(StringSession(session), api_id, api_hash) as client:
        if oldest:
            messages = await client.get_messages("me", limit=limit, reverse=True)
        else:
            messages = await client.get_messages("me", limit=limit)
        for message in messages:
            if message is None or not getattr(message, "id", None):
                continue
            items.append(_serialize(message))
    if oldest:
        items.reverse()
    return items


def _print_human(items: list[dict[str, Any]]) -> None:
    print(f"Saved Messages: {len(items)} item(s)\n")
    for index, item in enumerate(items, start=1):
        urls = ", ".join(item["urls"]) if item["urls"] else "-"
        print(f"{index}. [{item['kind']}] id={item['id']}  {item['date']}")
        print(f"   {item['preview'] or '(no text)'}")
        print(f"   urls: {urls}")
        print()


def main() -> int:
    _load_dotenv(ENV_PATH)
    parser = argparse.ArgumentParser(
        description="List Telegram Saved Messages for univer intake triage."
    )
    parser.add_argument("--limit", type=int, default=30, help="How many messages")
    parser.add_argument(
        "--oldest",
        action="store_true",
        help="Take oldest messages instead of newest",
    )
    parser.add_argument(
        "--json-out",
        type=Path,
        help="Write full JSON dump (default: print human summary only)",
    )
    parser.add_argument(
        "--json-stdout",
        action="store_true",
        help="Print JSON to stdout instead of human summary",
    )
    args = parser.parse_args()

    items = asyncio.run(_fetch(args.limit, args.oldest))
    if args.json_out:
        args.json_out.parent.mkdir(parents=True, exist_ok=True)
        args.json_out.write_text(
            json.dumps(items, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        print(f"Wrote {len(items)} item(s) → {args.json_out}", file=sys.stderr)
    if args.json_stdout:
        print(json.dumps(items, ensure_ascii=False, indent=2))
    else:
        _print_human(items)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
