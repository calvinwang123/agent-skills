---
name: harness-skill-backup
description: Maintain and restore a small, allowlisted skill bundle across coding-agent harnesses, using symlinks when supported and copies when they are not.
metadata:
  short-description: Back up and sync skills across harnesses
---

# Cross-harness skill backup

Use this skill when installing the repository's skills into another coding-agent harness, checking that an installation is complete, or maintaining a local backup and sync routine.

Keep the Git repositories as the source of truth. Do not copy credentials, tokens, cookies, private keys, caches, generated files, or live environment configuration.

## Installation model

Each harness needs two things:

1. Skill directories in the harness's supported discovery directory.
2. Short routing rules in the harness's persistent instruction file. A copied skill folder alone does not establish defaults or cross-skill routing.

Use one canonical checkout when a harness supports symlinks. Link each allowlisted skill directory into that harness's discovery directory. Symlinks reduce drift, but they work only while the checkout remains available and the harness follows symlinks. Use real copies for harnesses that reject symlinks, run on a different machine, or package skills for transport.

After installation, verify that the harness can discover the skill and that its persistent instruction file contains the relevant routing rules. Do not assume `AGENTS.md` travels with a copied repository.

## Allowlist

Sync only explicitly selected skill directories. For this bundle, the default allowlist is:

- `caveman`
- `unslop`
- `harness-skill-backup`

The school bundle is separate. Add `pfsense-openvpn` only when the target harness needs the school skill. Never merge the two repositories or copy school data into the general bundle.

## Backup and sync

Use [`scripts/sync-skills.sh`](scripts/sync-skills.sh) for repeatable local sync. It accepts a source repository, a target skill directory, and a mode. `symlink` replaces only matching allowlisted entries with links to the source checkout. `copy` updates only matching allowlisted entries as real directories. Use `--only --skill NAME` when syncing a skill from the separate school bundle. The script refuses unsafe names and reports conflicts instead of overwriting unrelated target entries.

Run the script manually after reviewing its target paths. A weekly timer may call it, but the timer must use fixed paths and an allowlist. Automatic sync may commit and push only files changed by the sync workflow, using existing Git credentials. Never put credentials in the script, unit files, logs, or repository.

For a new harness, first identify its skill discovery directory and persistent instruction file from its current documentation or configuration. Add a small routing block there, then run a normal request and one shared-document request to verify behavior.

For destructive replacement, inspect the target entry first and obtain confirmation immediately before deleting or replacing it. Prefer a backup copy or a reversible move when the harness does not support symlinks.
