# Production Release

## Резюме за собственика

Production е отделна от `main` и Staging. Преди всяко Production пускане собственикът получава точния проверен SHA, обобщение на промяната и риска, Staging доказателства, migration обобщение, backup статус, rollback процедура и известни ограничения. Пускането в Production започва само след като собственикът изрично одобри точно този кандидат. Одобрение за един SHA не одобрява различен SHA.

## Purpose and boundary

This document defines the future release package and owner approval gate. It does not authorize a Production deployment, migration, backup, provider access, or credential configuration during Phase 3.

Production is an owner-controlled security boundary. The normal coding agent and normal CI have no Production database administration, migration, service-role, MCP, Cloudflare deployment, backup-reader, recovery, or encryption-master capability. Credential absence is the control, not a defect. The authoritative capability policy is [Tool Policy](../governance/TOOL_POLICY.md).

## Release package

Before requesting a Production decision, assemble a release package for one exact verified candidate SHA containing:

1. The exact SHA and a plain-language description of what changes.
2. Fresh target-specific Staging verification evidence for that candidate.
3. A database migration summary, or an explicit statement that no migration is included.
4. Data risk and any expected effect on published content or operations.
5. Required full-release backup status and integrity result.
6. The tested rollback procedure and known limitations.
7. The explicit owner decision required: approve or decline Production promotion of that exact SHA.

A Production release cannot be inferred from a green PR, merge to `main`, Local checks, CI, or an older Staging result. `main` is a verified candidate for Staging, not a Production deployment.

## Owner approval gate

The release process stops as `OWNER DECISION REQUIRED` until the owner explicitly approves the exact SHA in the package. A change to the candidate, migration, target identity, data risk, backup status, or rollback basis requires a new package and approval.

Before any future authorized Production operation, prove repository, branch, exact SHA, declared environment, Supabase project reference, and Cloudflare target. Contradictory or missing target identity fails closed. Owner authorization does not permit bypassing this preflight.

## Backup and recovery prerequisite

A full release backup is required before every Production release. The authoritative backup, retention, encryption, and restore-rehearsal policy is [Backup and Restore](../infrastructure/BACKUP_AND_RESTORE.md); do not duplicate recovery material in a release package or this repository.

## When to stop

Use [Stop Conditions](../governance/STOP_CONDITIONS.md) for the required state and escalation packet whenever Production access, a destructive action, cost, account, legal/commercial choice, or scope expansion is involved. Use [Incident Runbook](INCIDENT_RUNBOOK_BG.md) when a release or live service incident occurs.
