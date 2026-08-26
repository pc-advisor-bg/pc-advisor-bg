# Phase 7 — Backup & Recovery Rehearsal Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development`. Use synthetic data only; never use real Production data for this pre-coding proof.

**Goal:** Prove the two-level backup design can create private integrity-checked artifacts and restore an encrypted logical database backup into an isolated local database.

**Architecture:** A synthetic snapshot exercises private R2 semantics in a temporary rehearsal-only bucket that is never the Production backup bucket. A synthetic local PostgreSQL dataset exercises logical dump, encryption, restore, verification, and cleanup. Production credentials are unnecessary.

**Tech Stack:** Local PostgreSQL/Supabase, PowerShell 5.1, compatible PostgreSQL dump/restore tools, private Cloudflare R2 rehearsal prefix/object, cryptographic hashing and approved encryption mechanism.

**Spec:** `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`

## Global Constraints

- Synthetic data only.
- R2 remains private.
- No backup secret in Git.
- No Production DB credential.
- No retained plaintext dump after rehearsal.
- Retention target: 30 Admin snapshots + 10 full release backups.

### Task 1: Define artifact contract with tests

**Files:**
- Modify: `docs/infrastructure/BACKUP_AND_RESTORE.md`
- Create: `tests/ops/backup-contract.tests.ps1`.

**Metadata fields:** kind, created-at, version/schema identifier when available, checksum, non-secret source environment label.

- [ ] Define deterministic filename patterns for snapshot and full-backup rehearsal artifacts.
- [ ] Define exact metadata validation rules.
- [ ] Write PASS test for valid metadata.
- [ ] Write FAIL test for modified payload/checksum mismatch.
- [ ] Run tests; verify RED before helper exists.

### Task 2: Implement rehearsal helper

**Files:**
- Create: `scripts/backup-rehearsal.ps1`.

**Modes:** `CreateSyntheticSnapshot`, `CreateLocalDbBackup`, `ValidateArtifact`, `RestoreLocalDb`, `RetentionDryRun`, `CleanupRehearsal`.

- [ ] Create deterministic synthetic component/catalog snapshot.
- [ ] Compute checksum with built-in cryptographic hashing.
- [ ] Validate checksum and required metadata.
- [ ] Ensure secret values are never printed.
- [ ] Run contract tests; verify GREEN.

### Task 3: Prove private R2 storage in an isolated rehearsal bucket

- [ ] The Phase Brief explicitly authorizes one temporary rehearsal-only R2 bucket and its later deletion.
- [ ] Create a temporary private rehearsal bucket that is **not** the Production backup bucket.
- [ ] If the current Cloudflare permission model cannot safely scope agent access to that rehearsal resource, the owner creates the bucket/temporary scoped credential and revokes it after the proof.
- [ ] Upload the synthetic encrypted object to the rehearsal bucket.
- [ ] Verify authenticated object existence.
- [ ] Attempt unauthenticated public retrieval; expected denied/unavailable.
- [ ] Retrieve through the approved rehearsal path.
- [ ] Validate checksum.
- [ ] Delete the specific rehearsal object.
- [ ] Delete the temporary rehearsal bucket after independent evidence capture.
- [ ] Revoke any temporary rehearsal credential.
- [ ] Verify the Production backup bucket was never accessed by the rehearsal workflow.

### Task 4: Create isolated synthetic local DB dataset

- [ ] Create isolated local rehearsal DB/schema.
- [ ] Insert deterministic rows prefixed `REHEARSAL_`.
- [ ] Record expected row counts and marker values.
- [ ] Verify no hosted DB connection is involved.

### Task 5: Logical dump + encryption

- [ ] Dump the isolated local rehearsal dataset using the compatible PostgreSQL logical backup tool.
- [ ] Encrypt using a runtime-supplied rehearsal secret that is never committed.
- [ ] Validate encrypted artifact is non-empty.
- [ ] Verify encrypted artifact is not readable as plaintext dump.
- [ ] Compute/store checksum metadata.
- [ ] Remove unnecessary plaintext dump after encrypted-artifact validation.

### Task 6: Restore into fresh isolated target

- [ ] Create a new empty local DB distinct from source.
- [ ] Decrypt into a temporary local file.
- [ ] Restore logical backup.
- [ ] Verify expected schema/table existence.
- [ ] Verify exact row counts.
- [ ] Verify deterministic markers.
- [ ] Destroy restored temporary DB.
- [ ] Remove decrypted temporary files.

### Task 7: Retention dry-run

- [ ] Generate synthetic metadata for 31 snapshots and 11 full backups.
- [ ] Mark newest required artifacts valid.
- [ ] Run retention in dry-run mode.
- [ ] Assert only oldest excess snapshot and oldest excess full backup are selected.
- [ ] Mark newest required artifact invalid.
- [ ] Assert cleanup refuses to remove previous known-good retained artifact.
- [ ] Do not mass-delete real R2 objects.

### Task 8: Independent recovery review

- [ ] Confirm no Production credential/data used.
- [ ] Confirm R2 public denial was actually tested.
- [ ] Confirm restore target was clean and separate.
- [ ] Confirm tamper detection works.
- [ ] Confirm plaintext temporary artifacts are cleaned.
- [ ] Confirm retention is exactly 30/10 and fail-safe.

### Task 9: Phase 7 gate

- [ ] Synthetic snapshot works.
- [ ] Private R2 proof passes.
- [ ] Public access denied.
- [ ] Logical backup encrypted.
- [ ] Isolated restore succeeds.
- [ ] Restored data validates.
- [ ] Tampered artifact rejected.
- [ ] Retention dry-run correct.
- [ ] Rehearsal bucket/temporary credential cleaned up.
- [ ] Production backup bucket never accessed.
- [ ] Cleanup complete.
- [ ] No Production data/credential used.

Stop. Do not activate Phase 8 automatically.
