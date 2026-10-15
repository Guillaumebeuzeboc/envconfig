---
name: use-rg
description: Prefer ripgrep for fast content search in shell commands
---

Always prefer `rg` over `grep` for shell-based content searches.

Use options that match the task:
- `-n` for line numbers
- `-i` for case-insensitive search
- `-S` for smart case
- `--glob` to scope file patterns

Avoid `grep` unless there is a strict compatibility requirement.
