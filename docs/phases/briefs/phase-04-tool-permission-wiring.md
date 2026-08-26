# Phase 4 Brief — Tool & Permission Wiring

- Status: Owner-approved
- Approved: 2026-08-26
- Phase: 4 — Tool & Permission Wiring
- Plan: `docs/superpowers/plans/phase-04-tool-permission-wiring.md`

## Goal

Establish and prove the minimum operational tool capabilities required for safe
PC Advisor BG engineering while preserving normal-agent and CI Production
absence.

## Business Outcome

The owner has a verifiable, recoverable tool boundary: ordinary engineering
can use the required repository, Local, Staging, browser, and documentation
paths without granting Production deployment or unrelated administrative work.

## Authoritative Docs

- `AGENTS.md`
- `docs/governance/PROJECT_CHARTER.md`
- `docs/governance/AGENT_AUTONOMY.md`
- `docs/governance/STOP_CONDITIONS.md`
- `docs/governance/TOOL_POLICY.md`
- `docs/governance/REPORTING_STANDARD.md`
- `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`
- `docs/superpowers/plans/phase-04-tool-permission-wiring.md`

## Included

1. Inventory and prove approved GitHub repository, pull-request, CI, and
   dedicated private Project operations.
2. Configure Local Supabase tooling and prove only the named PC Advisor BG
   Staging MCP target through safe read-only metadata.
3. Prove the dedicated PC Advisor BG Cloudflare account credential, declared
   future-Staging capabilities, absence of a Global API Key, and absence of a
   separate normal Production deploy credential.
4. Select exactly one browser verification stack.
5. Safely defer Sentry unless read-only diagnostics are activated at no cost.
6. Record documentation/research boundaries, consolidate the permission
   matrix, complete one whole-phase infrastructure/security review, and run
   the Phase 4 gate.

## Excluded

- Product coding, Phase 5 work, or Ready-to-Code activation.
- Production deployment, migration, credential, backup-reader, or provider
  mutation.
- Cloudflare Worker/application target creation; that belongs to Phase 5.
- GitHub visibility, collaborator, owner, billing, licensing, deletion,
  ruleset/branch-protection weakening, or other prohibited administration.
- Unrelated global integration modification or disabling.
- New paid resources, account ownership, legal, commercial, or scope changes.

## External Effects

Allowed reversible effects are temporary GitHub proof branches/PRs/Project
items with cleanup; Local Supabase containers; read-only provider metadata;
and owner-configured credentials in approved consumers. Provider write
operations remain limited to the task plan and must never target Production.

## Environments

- Local: reproducible synthetic-only tooling and Local Supabase.
- Staging: the explicitly named PC Advisor BG Supabase Staging MCP; future
  Cloudflare Staging capability only, with no application target in Phase 4.
- CI: narrowly scoped normal engineering credentials only; no Production
  secret or backup reader.
- Production: inaccessible to normal agent and CI.

## Required Tasks

Execute the nine tasks in the approved Phase 4 plan. Preserve completed Tasks
1–7 when their factual evidence conforms to this brief; do not repeat them
without a changed precondition. Task 8 consolidates proof and the one
whole-phase independent review. Task 9 runs only after review findings are
resolved.

## Reviews

One independent whole-phase infrastructure/security review after Task 8 is
required. Do not create per-task review loops. Material high-risk repairs may
use targeted review evidence without duplicating the whole-phase review.

## Tests

Run applicable tool preflight, target identity, capability, Local isolation,
secret/public-safety, governance, and required regression checks. Tie hosted
claims to target-specific fresh evidence. Record unavailable checks as gates.

## DoD

- Approved tool paths and forbidden normal Production boundaries are factually
  evidenced.
- Exactly one browser stack is selected.
- No secret or private identifier is committed or reported.
- Task 8 matrix and the one whole-phase review are resolved.
- Task 9 gate is evidenced and recovery ledger is current.
- Phase 5 remains inactive.

## Stops

Use `REPAIR` for deterministic in-brief technical defects, including Local
network exposure. Use `BLOCKED` for missing target identity, unavailable safe
capability, or unverified required boundary. Use `OWNER DECISION REQUIRED` for
money, Production, destructive actions, accounts, legal/commercial decisions,
or scope expansion. Never manufacture a Worker/application or Production
credential merely to produce evidence.

## Owner Decisions

- Sufficient project read/write access is preferred over permission
  minimization that blocks ordinary engineering.
- GitHub Administration read-only is explicitly permitted; prohibited GitHub
  administrative mutations remain prohibited.
- Unrelated owner/global integrations must not be disabled or altered.
- The dedicated PC Advisor BG Supabase Staging MCP is the authorized Supabase
  target.
- No Cloudflare Staging Worker/application exists in Phase 4; its absence is
  expected until Phase 5.
- Cloudflare Phase 4 proves correct account identity, valid credential,
  declared future-Staging capabilities, no Global API Key, and no separate
  Production deploy credential. Worker write execution is deferred to Phase 5.
- `GH_TOKEN` and `CLOUDFLARE_API_TOKEN` may persist at Windows User scope on
  this owner-controlled Windows account for this workflow, but must never be
  committed, printed, logged, placed in chat, or exposed in public artifacts.

## Owner Actions

The owner approves this brief and has supplied the permitted credentials and
target bindings outside Git. A new owner action is required only when a stop
condition or a documented unavailable boundary requires it.

## Recovery

Use `.superpowers/sdd/phase-04-tool-permission-wiring/progress.md` and the
Task 1–8 reports as factual recovery evidence. Preserve the current branch
and completed provisional work. Reconcile that evidence against this brief
rather than restarting completed work. Roll back only focused tracked changes
shown to violate this brief; never delete unrelated provider resources.