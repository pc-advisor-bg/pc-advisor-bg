# 0008 — Layered Backup Model

**Status:** Accepted

## Context

Routine owner-published changes and Production releases have different recovery
needs.

## Decision

Use routine Admin Publish snapshots and full release backups, with encrypted
private storage and isolated restore rehearsal.

## Consequences

Retention, encryption, and restore requirements are authoritative in [Backup and Restore](../infrastructure/BACKUP_AND_RESTORE.md).

## Reversal condition

Any change to backup scope, retention, encryption, or recovery access requires
explicit owner approval where it affects Production, cost, or recovery control.
