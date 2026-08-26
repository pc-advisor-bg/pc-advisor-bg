# Phase 2 — Repository & Local Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` task-by-task with fresh review.

**Goal:** Create the single public GitHub repository, establish protected Git flow, install the approved design/plan artifacts, and prove a reproducible Windows local foundation without starting product features.

**Architecture:** The repository begins with governance artifacts and local tooling only. Runtime versions are selected from current official compatibility evidence and pinned. GitHub protections are established before autonomous development.

**Tech Stack:** GitHub, Git, PowerShell 5.1, Node.js, fnm if needed, pnpm, Docker Desktop.

**Spec:** `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`

## Global Constraints

- Public repository; no open-source license.
- Issues/Discussions off.
- Private Organization Project.
- One official local worktree.
- `pnpm` only.
- No product features.
- No Production credential.

### Task 1: Read-only Windows preflight

**Files:**
- Create after repo bootstrap: `scripts/preflight.ps1`

- [ ] Run:

```powershell
$ErrorActionPreference = 'Continue'
git --version
where.exe git
node --version
where.exe node
pnpm --version
where.exe pnpm
fnm --version
nvm version
volta --version
docker version
docker info
```

- [ ] Record all discovered Node executable paths.
- [ ] Treat missing optional version managers as information, not automatic failure.
- [ ] Do not uninstall/reinstall Node during diagnosis.
- [ ] After repository bootstrap, encode the same read-only checks in `scripts/preflight.ps1` with non-zero exit only for required-tool failures or conflicting runtime state.
- [ ] Run `powershell -NoProfile -ExecutionPolicy Bypass -File .\\scripts\\preflight.ps1` and save the non-secret result in the Phase evidence.
- [ ] If no acceptable version manager exists, use `fnm` later through current official Windows instructions.

### Task 2: Select and pin Node/pnpm versions

**Files:**
- Create: `.node-version`
- Create/modify: `package.json`
- Create: `docs/decisions/0011-runtime-version-selection.md`

- [ ] Check current official compatibility docs for Next.js, selected Cloudflare path candidates, Supabase CLI, Node, and pnpm.
- [ ] Select a stable Node version supported by the full toolchain; prefer active LTS when compatible.
- [ ] Select a stable pnpm version supported by that Node version.
- [ ] Record exact versions + evidence/rationale in `0011-runtime-version-selection.md`.
- [ ] Write exact Node version to `.node-version`.
- [ ] Pin pnpm through supported package-manager metadata.
- [ ] Open a fresh PowerShell and verify exact selected versions.

### Task 3: Create the repository

**Files:** `README.md`

- [ ] Create exactly one repo under the dedicated Organization.
- [ ] Set visibility `Public`.
- [ ] Do not add MIT/Apache/GPL/other open-source license.
- [ ] Disable Issues.
- [ ] Disable Discussions.
- [ ] Keep Pull Requests enabled.
- [ ] README states: under development; source publicly viewable; all rights reserved; external contributions not accepted for V1.
- [ ] Verify no private owner email/secret is visible.

### Task 4: Establish official clone

- [ ] Confirm `C:\Users\Admin\Documents\pc-advisor-bg` does not contain an unrelated project.
- [ ] Clone repository to exactly that path.
- [ ] Run:

```powershell
Set-Location 'C:\Users\Admin\Documents\pc-advisor-bg'
git remote -v
git status --short --branch
git rev-parse --show-toplevel
git rev-parse HEAD
```

- [ ] Verify correct Organization remote and clean official worktree.
- [ ] Do not create “fresh”, “restart”, desktop, or duplicate working copies.

### Task 5: Install approved design and plan artifacts

**Files:**
- Create: `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`
- Create: `docs/superpowers/plans/2026-08-26-pc-advisor-project-os-master-implementation-plan.md`
- Create: `docs/superpowers/plans/phase-01-owner-foundation.md` through `phase-08-owner-agent-dry-run.md`

- [ ] Copy the owner-approved design artifact to the exact spec path.
- [ ] Copy the owner-approved plan files to the exact plan paths.
- [ ] Hash source and copied artifacts and verify equality.
- [ ] Commit only these approved docs and current README.

```powershell
git add README.md docs
git commit -m "docs: add approved project operating system design"
```

### Task 6: Public-repo safety baseline

**Files:**
- Create: `.gitignore`
- Create: `scripts/verify-public-repo-safety.ps1`

- [ ] Ignore secret-bearing env files, local Supabase runtime state, database dumps, private keys/certificates, test artifacts, and build output.
- [ ] Script fails if tracked filenames/content match forbidden secret/dump patterns.
- [ ] Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\verify-public-repo-safety.ps1
```

Expected: PASS.

- [ ] Create an untracked dummy `.env.local`; verify Git ignores it; delete it.
- [ ] Commit safety baseline.

### Task 7: Protect main

- [ ] Verify current public-repo GitHub Free ruleset capabilities from official docs.
- [ ] Block normal direct push to `main`.
- [ ] Require Pull Request.
- [ ] Disable force push and protected branch deletion.
- [ ] Require linear history if compatible with approved merge strategy.
- [ ] Do not require CI check names before they exist.
- [ ] Prove a harmless normal direct push to `main` is rejected; remove local probe state.

### Task 8: Create private Organization Project

- [ ] Create private Project.
- [ ] Add statuses: Backlog, Ready, In Progress, In Review, Blocked, Done.
- [ ] Add fields: Phase, Priority, Risk, Owner, Task/Plan reference, PR, Target Environment, Last Updated.
- [ ] Create Parking Lot view.
- [ ] Add Phase 3 as a private draft item, not repository Issue.

### Task 9: Clean-clone review

- [ ] Fresh reviewer checks public repository for private values.
- [ ] Clone into a temporary directory.
- [ ] Verify spec/plans and runtime pin files are present.
- [ ] Run public-repo safety script in temp clone.
- [ ] Delete temp clone.
- [ ] Verify official worktree clean/synchronized.

### Task 10: Phase 2 gate

- [ ] One public repo exists.
- [ ] No open-source license.
- [ ] Issues/Discussions off.
- [ ] Private Project ready.
- [ ] `main` rejects normal direct pushes.
- [ ] Official Windows clone exists.
- [ ] Runtime versions verified/pinned.
- [ ] Approved spec/plans committed.
- [ ] Public-repo safety proof passes.
- [ ] No product feature code.

Stop. Do not activate Phase 3 automatically.
