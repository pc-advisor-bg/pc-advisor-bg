# Phase 5 — Environment Skeleton & Security Proof Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development`. Any Production-skeleton external effect must be explicitly listed in the approved Phase Brief before execution.

**Goal:** Create a minimal non-product application/environment skeleton, prove Local/Staging separation, prepare locked Production infrastructure, and make mistaken target selection fail closed.

**Architecture:** A tiny Next.js shell exists only to exercise build/deploy/security paths. Local Supabase is disposable. Staging is autonomous and protected. Production is prepared minimally, but normal agent Production credentials remain absent.

**Tech Stack:** Next.js, TypeScript, pnpm, Supabase CLI/Docker, current stable Cloudflare Next.js deployment path, Cloudflare Access, private R2.

**Spec:** `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`

## Global Constraints

- No product feature work.
- No real Production data.
- No normal agent Production deploy/DB credential.
- Staging remains protected and `noindex`.
- Exact Cloudflare adapter/path is selected from current official stable support and pinned.
- Production-skeleton creation requires explicit owner authorization in the Phase Brief.

### Task 1: Select and pin the Cloudflare Next.js path

**Files:**
- Create: `docs/decisions/0013-cloudflare-nextjs-deployment-path.md`
- Modify: `package.json`
- Create/modify: deployment configuration required by selected path.

- [ ] Check current official Cloudflare/framework documentation for stable Next.js deployment options.
- [ ] Select the simplest stable option that supports required Next.js features, Workers, bindings, and CI.
- [ ] Reject beta/experimental options when a stable option satisfies requirements.
- [ ] Record exact package names, versions, config files, and rationale.
- [ ] Pin dependencies with pnpm; do not perform unrelated upgrades.

### Task 2: TDD the minimal health contract

**Files:**
- Create: `src/app/api/health/route.ts` or the exact framework-equivalent path selected by Task 1.
- Create: `tests/health.test.ts`.
- Create minimal framework files required to build.

**Interface:** `GET /api/health` returns HTTP 200 and deterministic safe JSON containing `ok: true` and `service: "pc-advisor-bg"`.

- [ ] Write a failing test asserting status 200 and exact safe JSON fields.
- [ ] Run the focused test; verify RED because route is absent.
- [ ] Implement the minimal route with no DB access and no secret output.
- [ ] Run focused test; verify GREEN.
- [ ] Run lint, typecheck, test, and production build.
- [ ] Commit the minimal infrastructure shell.

### Task 3: Initialize reproducible Local Supabase

**Files:**
- Create: `supabase/config.toml`
- Create only minimal setup fixtures needed for environment proof.

- [ ] Initialize local Supabase.
- [ ] Start through Docker.
- [ ] Record non-secret local status.
- [ ] Stop/reset/start and prove reproducibility.
- [ ] Verify local reset does not touch hosted projects.
- [ ] Keep local runtime secrets/state out of Git.

### Task 4: TDD environment identity guard

**Files:**
- Create: `scripts/assert-environment.ps1`
- Create: `tests/ops/assert-environment.tests.ps1`

**Interface:** accepts expected/actual environment plus optional Supabase ref and Cloudflare target. Exit 0 only on expected identity; non-zero on contradiction.

- [ ] Write PASS case: expected Staging / actual Staging.
- [ ] Write FAIL case: expected Staging / actual Production.
- [ ] Write FAIL case: mismatched Supabase refs.
- [ ] Write FAIL case: mismatched Cloudflare targets.
- [ ] Run tests; verify RED before script exists.
- [ ] Implement minimal PowerShell guard.
- [ ] Run tests; verify GREEN.
- [ ] Ensure error output contains identifiers only, never secrets.

### Task 5: Create protected Staging application target

**Files:**
- Modify: `docs/operations/STAGING.md`
- Use deployment configuration from Task 1.

- [ ] Create Staging Worker/application target using Staging-scoped credential.
- [ ] Deploy minimal shell.
- [ ] Verify deployed `/api/health`.
- [ ] Configure `noindex`.
- [ ] Configure Cloudflare Access to block public browsing.
- [ ] Configure a machine/service path for later automated browser checks without owner personal login.
- [ ] Verify unauthenticated access is blocked and authorized test access succeeds.

### Task 6: Prepare locked Production skeleton

**Files:**
- Modify: `docs/infrastructure/CLOUDFLARE.md`
- Modify: `docs/infrastructure/SECRETS.md`

- [ ] Confirm Phase Brief explicitly authorizes each Production-skeleton external effect.
- [ ] Owner creates/authorizes the minimal Production application target.
- [ ] Do not place Production deployment token in normal agent/GitHub CI.
- [ ] Do not make `main` deploy Production.
- [ ] Record symbolic Production target name only in public docs.

### Task 7: Create owner-controlled private Production R2 backup storage

**Files:**
- Modify: `docs/infrastructure/BACKUP_AND_RESTORE.md`.

- [ ] Verify current R2/account configuration can satisfy approved zero-cost setup; if not, stop for owner cost decision.
- [ ] Owner creates one dedicated private Production backup bucket using owner-controlled Cloudflare access.
- [ ] Ensure public bucket access/custom public domain is off.
- [ ] Do not grant the normal coding agent or Staging Worker access to this Production backup bucket.
- [ ] Define the future Production-runtime binding strategy so approved Publish snapshots can write through the Production Worker binding without a general R2 API token in the coding-agent environment.
- [ ] Record the real bucket identifier only in the private owner inventory where appropriate; public docs use a symbolic name.
- [ ] Do not write real Production data.

### Task 8: Fail-closed proof

**Files:**
- Create: `scripts/verify-staging.ps1`
- Modify: `scripts/assert-environment.ps1`.

- [ ] Run guard with correct Staging identity; expected PASS.
- [ ] Inject a synthetic Production target label/ref into local invocation; expected FAIL before any network mutation.
- [ ] Verify Staging deploy path invokes identity guard before provider mutation.
- [ ] Verify normal CI environment lacks Production DB/deploy credential.
- [ ] Security reviewer confirms separation relies on credential absence as well as names.

### Task 9: Phase 5 gate

- [ ] Local reset/restart works.
- [ ] Minimal shell builds.
- [ ] Staging health works.
- [ ] Staging is Access-protected and noindex.
- [ ] Machine browser access path exists.
- [ ] Production normal deploy credential absent.
- [ ] Production DB mutation access absent.
- [ ] Private R2 bucket exists with public access disabled.
- [ ] Deliberate Staging→Production mismatch fails closed.
- [ ] No product feature implemented.

Stop. Do not activate Phase 6 automatically.
