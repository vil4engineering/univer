#!/usr/bin/env python3
from __future__ import annotations

import argparse
import asyncio
import json
import os
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ENV_PATH = ROOT / ".env"
PENDING_PATH = ROOT / ".tg-login-pending.json"


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


def _upsert_env(path: Path, key: str, value: str) -> None:
    lines: list[str] = []
    if path.is_file():
        lines = path.read_text(encoding="utf-8").splitlines()
    found = False
    out: list[str] = []
    for line in lines:
        if line.startswith(f"{key}=") or line.startswith(f"{key} ="):
            out.append(f"{key}={value}")
            found = True
        else:
            out.append(line)
    if not found:
        out.append(f"{key}={value}")
    path.write_text("\n".join(out).rstrip() + "\n", encoding="utf-8")


async def _request_code(phone: str) -> None:
    from telethon import TelegramClient
    from telethon.sessions import StringSession

    api_id = int(os.environ["TELEGRAM_API_ID"].strip())
    api_hash = os.environ["TELEGRAM_API_HASH"].strip()
    client = TelegramClient(StringSession(), api_id, api_hash)
    await client.connect()
    sent = await client.send_code_request(phone)
    session = client.session.save()
    await client.disconnect()
    PENDING_PATH.write_text(
        json.dumps(
            {
                "phone": phone,
                "phone_code_hash": sent.phone_code_hash,
                "session": session,
            },
            ensure_ascii=False,
            indent=2,
        )
        + "\n",
        encoding="utf-8",
    )


async def _complete_login(code: str, password: str | None) -> str:
    from telethon import TelegramClient
    from telethon.errors import SessionPasswordNeededError
    from telethon.sessions import StringSession

    if not PENDING_PATH.is_file():
        raise SystemExit("No pending login. Run with --phone first.")
    pending = json.loads(PENDING_PATH.read_text(encoding="utf-8"))
    phone = pending["phone"]
    phone_code_hash = pending["phone_code_hash"]
    session = pending["session"]

    api_id = int(os.environ["TELEGRAM_API_ID"].strip())
    api_hash = os.environ["TELEGRAM_API_HASH"].strip()
    client = TelegramClient(StringSession(session), api_id, api_hash)
    await client.connect()
    try:
        await client.sign_in(phone=phone, code=code, phone_code_hash=phone_code_hash)
    except SessionPasswordNeededError:
        mid_session = client.session.save()
        PENDING_PATH.write_text(
            json.dumps(
                {
                    "phone": phone,
                    "phone_code_hash": phone_code_hash,
                    "session": mid_session,
                    "awaiting_2fa": True,
                },
                ensure_ascii=False,
                indent=2,
            )
            + "\n",
            encoding="utf-8",
        )
        if not password:
            await client.disconnect()
            raise SystemExit("NEED_2FA")
        await client.sign_in(password=password)
    final_session = client.session.save()
    await client.disconnect()
    PENDING_PATH.unlink(missing_ok=True)
    return final_session


async def _complete_2fa(password: str) -> str:
    from telethon import TelegramClient
    from telethon.sessions import StringSession

    if not PENDING_PATH.is_file():
        raise SystemExit("No pending 2FA login. Start again with --phone.")
    pending = json.loads(PENDING_PATH.read_text(encoding="utf-8"))
    if not pending.get("awaiting_2fa"):
        raise SystemExit("Login is not waiting for 2FA. Pass --code first.")

    api_id = int(os.environ["TELEGRAM_API_ID"].strip())
    api_hash = os.environ["TELEGRAM_API_HASH"].strip()
    client = TelegramClient(StringSession(pending["session"]), api_id, api_hash)
    await client.connect()
    await client.sign_in(password=password)
    final_session = client.session.save()
    await client.disconnect()
    PENDING_PATH.unlink(missing_ok=True)
    return final_session

def main() -> int:
    _load_dotenv(ENV_PATH)
    parser = argparse.ArgumentParser(description="Create TELEGRAM_SESSION into .env")
    parser.add_argument("--phone", help="International phone, e.g. +380...")
    parser.add_argument("--code", help="Login code from Telegram")
    parser.add_argument("--password", help="2FA password if enabled")
    args = parser.parse_args()

    if not os.environ.get("TELEGRAM_API_ID") or not os.environ.get("TELEGRAM_API_HASH"):
        print("TELEGRAM_API_ID / TELEGRAM_API_HASH missing in env or .env", file=sys.stderr)
        return 2

    if args.password and not args.code and PENDING_PATH.is_file():
        pending = json.loads(PENDING_PATH.read_text(encoding="utf-8"))
        if pending.get("awaiting_2fa"):
            session = asyncio.run(_complete_2fa(args.password))
            _upsert_env(ENV_PATH, "TELEGRAM_SESSION", session)
            print(f"Saved TELEGRAM_SESSION to {ENV_PATH}")
            return 0

    if args.code:
        try:
            session = asyncio.run(_complete_login(args.code, args.password))
        except SystemExit as exc:
            if str(exc) == "NEED_2FA":
                print("NEED_2FA")
                print("2FA enabled. Re-run with --password only.")
                return 0
            raise
        _upsert_env(ENV_PATH, "TELEGRAM_SESSION", session)
        print(f"Saved TELEGRAM_SESSION to {ENV_PATH}")
        return 0

    if not args.phone:
        print("Need --phone to request a code", file=sys.stderr)
        return 2

    asyncio.run(_request_code(args.phone))
    print("CODE_SENT")
    print("Code requested. Re-run with --code.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
