# Phase 6 — CI, Review & Release Conveyor Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` with fresh implementer and reviewer. This phase uses only a trivial reversible fixture.

**Goal:** Prove branch → TDD → review → PR → required CI → green auto-merge → protected Staging deployment, while proving Production is not part of the normal merge path.

**Architecture:** Base CI runs on every PR. Risk-triggered review/checks are mapped separately. A tiny health-contract change exercises the entire workflow without creating a product feature.

**Tech Stack:** GitHub Actions, pnpm, Next.js shell, PowerShell guards, selected browser stack, Cloudflare Staging.

**Spec:** `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`

## Global Constraints

- No direct push to `main`.
- No Production deploy.
- No weakened test/check.
- Base PR checks: lint, typecheck, unit/regression tests, production build, secret/security scan.
- Full relevant suite + broad review at phase end.

### Task 1: Create base CI

**Files:**
- Create: `.github/workflows/ci.yml`
- Modify: `package.json`.

**Stable check names produced:** `lint`, `typecheck`, `test`, `build`, `secret-scan`.

- [ ] Add deterministic package scripts for lint/typecheck/tests/build/safety scan.
- [ ] Use pinned Node and pnpm.
- [ ] Use frozen lockfile install.
- [ ] Ensure CI jobs receive no Production secrets.
- [ ] Open PR and prove all five checks report independently.
- [ ] Repair any CI-only defect within scope.
- [ ] Merge only after review + green checks.

### Task 2: Make CI required on main

- [ ] Add stable check names to GitHub required checks.
- [ ] Preserve PR requirement and no-force-push policy.
- [ ] Enable approved auto-merge.
- [ ] Create a harmless failing PR probe and prove it cannot merge.
- [ ] Close/remove the probe without weakening rules.

### Task 3: Create verification matrix

**Files:**
- Create: `docs/governance/VERIFICATION_MATRIX.md`
- Modify: `AGENTS.md` only to route to this file if needed.

- [ ] Map `supabase/**`, Auth, RLS → DB/security review/tests.
- [ ] Map recommendation engine → invariant/property/correctness review.
- [ ] Map public UI → browser + accessibility.
- [ ] Map deploy/config → infra/security.
- [ ] Map SEO/content → source/copyright.
- [ ] Keep base CI universal.
- [ ] Do not create brittle automation that can silently skip required risk review.
- [ ] Independently review the matrix.

### Task 4: Create Staging deploy workflow

**Files:**
- Create: `.github/workflows/staging-deploy.yml`
- Modify: `scripts/assert-environment.ps1`
- Modify: `scripts/verify-staging.ps1`.

- [ ] Trigger only from verified `main` using the selected GitHub workflow pattern.
- [ ] Call environment guard before provider mutation.
- [ ] Use only Staging Cloudflare credential.
- [ ] Deploy exact checked-out SHA.
- [ ] Run post-deploy health verification.
- [ ] Record deployed SHA in workflow/deployment metadata when supported.
- [ ] Verify no Production deployment step or Production secret reference exists.

### Task 5: TDD trivial conveyor fixture

**Files:**
- Modify: `tests/health.test.ts`
- Modify: `src/app/api/health/route.ts`.

**Interface change:** health JSON gains `"stage": "setup"`.

- [ ] Create fresh task branch.
- [ ] Change test to require `stage: "setup"`.
- [ ] Run focused test; expected RED.
- [ ] Add exactly the constant field to health response.
- [ ] Run focused test; expected GREEN.
- [ ] Run all base local checks.
- [ ] Fresh reviewer confirms no product scope expansion.
- [ ] Commit `test(ops): exercise verified staging conveyor`.
- [ ] Push and open PR.

### Task 6: Prove autonomous repair

- [ ] Introduce one controlled harmless branch-only test fixture mismatch.
- [ ] Push and prove CI fails.
- [ ] Agent diagnoses without owner micro-authorization.
- [ ] Repair root cause correctly.
- [ ] Rerun relevant local checks and push.
- [ ] Reviewer confirms checks were not bypassed or weakened.

### Task 7: Prove auto-merge and Staging

- [ ] Required CI green.
- [ ] Required review has no blocker.
- [ ] Enable/use approved auto-merge.
- [ ] Capture merged exact SHA.
- [ ] Verify Staging deployment uses that exact SHA.
- [ ] Verify Staging health payload.
- [ ] Run selected browser smoke through protected access.
- [ ] Verify Production target is unchanged.

### Task 8: Checkpoint-report proof

- [ ] Report in Bulgarian: Какво се промени / Как доказахме / Твоето действие / Какво следва / Състояние.
- [ ] Put SHA/PR/check details below human summary.
- [ ] Do not use raw terminal logs as primary report.

### Task 9: Phase 6 gate

- [ ] Base CI green.
- [ ] Failing required check blocks merge.
- [ ] Green reviewed PR auto-merges.
- [ ] Exact merged SHA reaches protected Staging.
- [ ] Browser smoke succeeds.
- [ ] Production unchanged.
- [ ] No Production credential in workflow.
- [ ] Broad independent phase review green.

Stop. Do not activate Phase 7 automatically.
