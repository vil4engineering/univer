# Checklist: Graph health

Definition of Done for knowledge-graph integrity (Architect). Honest about tooling limits.

## Automated (required)

```bash
python3 scripts/check_library_sync.py
```

- [ ] Exit code **0** (`library sync OK`)
- [ ] No disk↔`TOPIC_TREE` orphans

This script checks warehouse folder sync only. It does **not** detect broken Markdown links or semantic duplicate concepts.

## Architect judgment (required on create / merge / move)

- [ ] No semantic duplicate of an existing concept under another name
- [ ] Canonical path designated; projections will reference it
- [ ] Campus-first / Library-warehouse placement correct
- [ ] No top-level Handbook / Decision Book / Production Playbook tree without Design revision
- [ ] Required cross-links listed (prerequisites / siblings / follow-ups)
- [ ] Graph impact: improves (not clutter)

## Optional later (out of this pass)

- Broken internal-link crawler
- Automated terminology consistency

## Related

- [architecture.md](architecture.md)
- [../roles/architect.md](../roles/architect.md)
- `scripts/write_library_map.py`
