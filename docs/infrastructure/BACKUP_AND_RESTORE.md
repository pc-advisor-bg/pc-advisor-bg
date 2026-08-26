# Backup and Restore

## Purpose

This document is the authoritative technical policy for PC Advisor BG backup levels, encrypted retention, and restore rehearsal. It defines future operating requirements only; it does not create backups, access Production data, configure R2, or authorize a restore.

## Backup levels

### Admin Publish snapshot

A routine snapshot protects owner-managed catalog, content, and configuration changes.

- Trigger only after a successful Publish, never after a draft save.
- Required sequence: `Publish → validate → save/audit → version snapshot → encrypted private R2 storage → health status`.
- The Production runtime uses an approved private R2 binding; normal agent workflows do not receive a general R2 credential.

### Full release backup

A full release backup is required before every Production release.

- Required sequence: `Production DB → read-only backup credential → logical dump → encryption → private R2 → integrity verification`.
- The Production backup reader and encryption master material remain owner-controlled and outside normal agent and GitHub CI access.
- Production promotion requires the owner's explicit approval of the exact verified candidate; merging `main` does not replace this prerequisite.

## Retention and encryption

- Retain the latest **30** successful Admin Publish snapshots.
- Retain the latest **10** successful full release backups.
- Every stored archive is encrypted before private R2 storage.
- Remove an older backup only after its newer required replacement is validated.
- Secret inventory, storage, and rotation authority is [SECRETS.md](SECRETS.md); this document does not duplicate secret values or recovery material.

## Restore rehearsal

Restore capability must be proven:

- before public launch; and
- after every significant database or schema change.

Rehearsals restore into a temporary, isolated local PostgreSQL/Docker environment. Verify the archive, schema, key data, and relevant application compatibility, then destroy the temporary environment. Do not copy Production data into permanent Staging.

Record the last restore verification and backup health for owner visibility. A failed or unproven rehearsal is a recovery condition to report; it does not justify bypassing the Production boundary.

## Related authorities

- [STOP_CONDITIONS.md](../governance/STOP_CONDITIONS.md) — Production approval and access stops.
- [TOOL_POLICY.md](../governance/TOOL_POLICY.md) — Production credential boundary.
- [CLOUDFLARE.md](CLOUDFLARE.md) — private R2 policy.
- [SECRETS.md](SECRETS.md) — symbolic secret inventory and rotation.