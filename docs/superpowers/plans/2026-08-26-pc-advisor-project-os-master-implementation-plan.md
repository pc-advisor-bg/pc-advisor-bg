# PC Advisor BG Project Operating System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build and prove the complete pre-coding operating system that lets an autonomous agent work safely in Local/Staging while the owner retains control of accounts, money, Production, destructive actions, and scope.

**Architecture:** Eight separately gated setup phases establish ownership, repository governance, documentation, permissions, environment isolation, CI/release flow, recovery, and a fresh-agent dry run. Product feature work remains forbidden until all gates pass.

**Tech Stack:** Windows + PowerShell 5.1, Git/GitHub, Node.js, pnpm, Docker Desktop, Next.js shell, Supabase/PostgreSQL, Cloudflare Workers/Access/R2, GitHub Actions, one browser verification stack, optional read-only Sentry.

**Spec:** `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`

## Global Constraints

- Superpowers is the only software-development methodology.
- One public GitHub Organization repository; public source, no open-source license.
- GitHub Issues and Discussions stay disabled; internal work uses private Organization Project draft items.
- Official worktree: `C:\Users\Admin\Documents\pc-advisor-bg`.
- `pnpm` only.
- Mandatory recurring infrastructure target is €0.
- No paid resource or automatic paid upgrade without owner approval.
- Normal agent/CI has no Production Supabase MCP, Production DB mutation credential, normal Production Cloudflare deploy credential, Production backup reader, Bitwarden credential, or recovery credential.
- Verified `main` may deploy Staging but never Production.
- Staging stays protected and `noindex`.
- V1 has no external AI runtime.
- Real secret values never enter public Git, plans, screenshots, logs, or chat.
- Product feature implementation is forbidden before the Ready-to-Code Gate.

---

## Locked File Map

```text
AGENTS.md
README.md
.github/
  workflows/
    ci.yml
    staging-deploy.yml
  pull_request_template.md
docs/
  owner/
    OWNER_GUIDE_BG.md
    GLOSSARY_BG.md
    DAY_ZERO_SETUP_BG.md
  governance/
    PROJECT_CHARTER.md
    AGENT_AUTONOMY.md
    STOP_CONDITIONS.md
    TOOL_POLICY.md
    REPORTING_STANDARD.md
    VERIFICATION_MATRIX.md
  infrastructure/
    GITHUB.md
    SUPABASE.md
    CLOUDFLARE.md
    SECRETS.md
    BACKUP_AND_RESTORE.md
  operations/
    ADMIN_OPERATIONS_BG.md
    STAGING.md
    PRODUCTION_RELEASE.md
    INCIDENT_RUNBOOK_BG.md
  phases/
    PHASES.md
    briefs/
  decisions/
  superpowers/
    specs/
    plans/
scripts/
  preflight.ps1
  assert-environment.ps1
  verify-governance.ps1
  verify-public-repo-safety.ps1
  verify-staging.ps1
  backup-rehearsal.ps1
.superpowers/
  sdd/
```

## Phase Activation Pattern

For every Phase 1–8:

- [ ] Read the approved spec and that phase plan.
- [ ] Verify the previous phase gate evidence.
- [ ] Present one Bulgarian Phase Brief: Goal, Included, Excluded, Owner Actions, Allowed External Effects, Reviews, Tests, Stop Conditions, Definition of Done.
- [ ] Obtain one owner approval for the whole phase package.
- [ ] Execute autonomously inside that scope.
- [ ] Run independent phase review.
- [ ] Stop at the phase gate. Do not activate the next phase automatically.

## Phase Order

- [ ] Phase 1 — Owner Foundation
- [ ] Phase 2 — Repository & Local Foundation
- [ ] Phase 3 — Project Operating System Installation
- [ ] Phase 4 — Tool & Permission Wiring
- [ ] Phase 5 — Environment Skeleton & Security Proof
- [ ] Phase 6 — CI, Review & Release Conveyor
- [ ] Phase 7 — Backup & Recovery Rehearsal
- [ ] Phase 8 — Owner/Agent Dry Run

## Master Ready-to-Code Verification

- [ ] Owner controls Proton, Bitwarden, GitHub Org, Supabase, Cloudflare.
- [ ] Current mandatory recurring infrastructure cost is verified as €0.
- [ ] Public repository contains no secrets.
- [ ] `main` is PR-only and failing required checks block merge.
- [ ] Green task can auto-merge.
- [ ] Verified `main` reaches protected Staging.
- [ ] Normal merge cannot deploy Production.
- [ ] Normal agent cannot mutate Production DB.
- [ ] Local environment is reproducible from repository instructions.
- [ ] Environment mismatch fails closed before hosted mutation.
- [ ] Backup artifact integrity proof succeeds.
- [ ] Isolated restore rehearsal succeeds.
- [ ] Fresh agent recovers current state without chat memory.
- [ ] Normal repair happens without micro-authorization.
- [ ] Paid-resource simulation stops correctly.
- [ ] Production-mutation simulation stops correctly.
- [ ] Scope-expansion simulation stops correctly.
- [ ] Broad independent Project Operating System review has no unresolved blocker.
- [ ] Only then declare `PROJECT OPERATING SYSTEM: READY`.
