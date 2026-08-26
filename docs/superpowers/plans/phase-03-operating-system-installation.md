# Phase 3 — Project Operating System Installation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` with fresh implementation and review.

**Goal:** Install the layered governance and owner-documentation system and prove that a fresh agent can recover authority/boundaries without chat history.

**Architecture:** `AGENTS.md` is a concise constitution/router. Each rule has one authoritative home. Bulgarian docs explain owner operations; English docs govern technical execution.

**Tech Stack:** Markdown, PowerShell validation, GitHub private Project.

**Spec:** `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`

## Global Constraints

- Avoid duplicated policy.
- Technical layer English; owner layer Bulgarian.
- `AGENTS.md` target ~200–350 structured lines.
- No product features.
- No real secrets in docs.

### Task 1: Governance layer

**Files:**
- Create: `AGENTS.md`
- Create: `docs/governance/PROJECT_CHARTER.md`
- Create: `docs/governance/AGENT_AUTONOMY.md`
- Create: `docs/governance/STOP_CONDITIONS.md`
- Create: `docs/governance/TOOL_POLICY.md`
- Create: `docs/governance/REPORTING_STANDARD.md`

- [ ] Write charter from approved product context/exclusions.
- [ ] Write exact autonomy boundary.
- [ ] Define `REPAIR`, `BLOCKED`, `OWNER DECISION REQUIRED`.
- [ ] Define minimum permanent toolset and forbidden Production access.
- [ ] Define Bulgarian owner-first reporting template.
- [ ] Write `AGENTS.md` as router/constitution, linking rather than duplicating policies.
- [ ] In `AGENT_AUTONOMY.md` define the recovery ledger contract at `.superpowers/sdd/<phase>/progress.md` with current phase, task, last verified SHA, checks, PR, blocker, next authorized action, and Staging state.
- [ ] Search all governance docs for contradictions and consolidate.

### Task 2: Owner layer

**Files:**
- Create: `docs/owner/OWNER_GUIDE_BG.md`
- Create: `docs/owner/GLOSSARY_BG.md`
- Create: `docs/owner/DAY_ZERO_SETUP_BG.md`

- [ ] Explain browser → Cloudflare → app → Supabase in Bulgarian.
- [ ] Explain Local/Staging/Production, GitHub, deploy, migration, backup, Admin.
- [ ] Include a simple ASCII system diagram.
- [ ] Define commit, branch, PR, CI, SHA, migration, rollback, RLS, secret, environment, backup, restore, deploy.
- [ ] Convert verified Phase 1 instructions into canonical Day Zero guide.
- [ ] Every owner command/action includes What/Why/Risk/Expected/If different/Do not share.
- [ ] Never include actual owner email, project ref, token, password, or recovery code.

### Task 3: Infrastructure docs

**Files:**
- Create: `docs/infrastructure/GITHUB.md`
- Create: `docs/infrastructure/SUPABASE.md`
- Create: `docs/infrastructure/CLOUDFLARE.md`
- Create: `docs/infrastructure/SECRETS.md`
- Create: `docs/infrastructure/BACKUP_AND_RESTORE.md`

- [ ] Document GitHub ownership, public-source status, PR/private Project flow, forbidden org changes.
- [ ] Document Supabase Local/Staging/Production, Auth owner model, RLS, no Production MCP, no service-role by default.
- [ ] Document Cloudflare Staging/Production separation, Access/noindex, scoped token, R2, no Global API Key.
- [ ] Document symbolic secret inventory: purpose, storage, authorized consumer, rotation.
- [ ] Document backup levels, 30/10 retention, encryption, pre-release full backup, restore rehearsal.

### Task 4: Operations docs

**Files:**
- Create: `docs/operations/ADMIN_OPERATIONS_BG.md`
- Create: `docs/operations/STAGING.md`
- Create: `docs/operations/PRODUCTION_RELEASE.md`
- Create: `docs/operations/INCIDENT_RUNBOOK_BG.md`

- [ ] Explain Admin business-operation boundary.
- [ ] Explain Staging autonomy and test-data-only rule.
- [ ] Define Production release package and owner approval gate.
- [ ] Add Bulgarian incident procedures for site down, Admin down, DB down, wrong published data, suspected secret leak, bad deploy, backup failure.
- [ ] Each incident procedure says what the owner must not do.

### Task 5: Phases and decisions

**Files:**
- Create: `docs/phases/PHASES.md`
- Create: `docs/phases/briefs/.gitkeep`
- Create: `docs/decisions/README.md`
- Create decision records `0001` through `0010` for the approved irreversible/tempting-to-reverse choices.

- [ ] Define setup Phases 0–8 and expected future product roadmap.
- [ ] Define canonical Phase Brief structure: Goal, Business Outcome, Authoritative Docs, Included, Excluded, External Effects, Environments, Reviews, Tests, DoD, Stops, Owner Decisions, Owner Actions, Recovery.
- [ ] Write concise Context / Decision / Consequences / Reversal condition records for hosting, licensing posture, private Project tracking, Production isolation, no AI V1, affiliate neutrality, Admin boundary, backup model, one repo, €0 target.

### Task 6: Governance verifier

**Files:**
- Create: `scripts/verify-governance.ps1`

- [ ] Verify required operating-system files exist.
- [ ] Fail on unfinished-marker tokens in authoritative docs; the verifier must search for the conventional task/deferred-work markers without allowing them in approved policy text.
- [ ] Fail on obvious secret assignments in tracked Markdown.
- [ ] Verify `AGENTS.md` routes to autonomy, stop, tool, reporting docs.
- [ ] Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\verify-governance.ps1
```

Expected: PASS.

### Task 7: Fresh-agent comprehension test

- [ ] Dispatch reviewer with repo docs only, no chat summary.
- [ ] Ask whether it may: pay €5; deploy Production; repair Staging test without asking; add Redis; use Production Supabase MCP; activate a future idea.
- [ ] Expected: No; No; Yes inside scope; No; No; No—Parking Lot only.
- [ ] Any wrong answer is a documentation defect.
- [ ] Repair and retest with another fresh reviewer.

### Task 8: Review, PR, merge

- [ ] Independent review for duplication, contradiction, owner readability, and missing boundaries.
- [ ] Run governance and public-repo safety scripts.
- [ ] Commit coherent doc groups.
- [ ] PR/review/merge only when green under available protections.

### Task 9: Phase 3 gate

- [ ] All approved docs exist.
- [ ] Governance verifier passes.
- [ ] Public-repo safety passes.
- [ ] Fresh agent understands boundaries correctly.
- [ ] Owner docs are clear Bulgarian.
- [ ] No real secret in docs.
- [ ] `main` remains protected.

Stop. Do not activate Phase 4 automatically.
