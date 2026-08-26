# Phases

## Purpose

This document defines the pre-coding setup sequence, the Phase Brief contract,
and the expected product roadmap direction. It does not approve a future phase.
The active approved brief is the only authorization for code or infrastructure
work. Authority for product scope is [Project Charter](../governance/PROJECT_CHARTER.md);
autonomy and stops remain in their respective governance documents.

## Setup phases

Each setup phase ends at its gate. Completion of one phase does not activate the
next.

| Phase | Scope | Gate |
| --- | --- | --- |
| 0 — Project Operating System Specification | Approved architecture, design specification, owner review, and setup plan. | No account setup, repository mutation, or product coding occurs before this gate. |
| 1 — Owner Foundation | Owner-controlled project identities, recovery structure, and provider accounts. | Owner controls accounts and recovery; the agent has no master credentials. |
| 2 — Repository & Local Foundation | Public-source repository, protected Git flow, private Project, and reproducible Windows local foundation. | A clean checkout is reproducible and the repository contains no secrets. |
| 3 — Project Operating System Installation | Layered governance, owner documentation, and phase/task structures. | A fresh agent can explain authority, boundaries, environments, and stops from repository documents. |
| 4 — Tool & Permission Wiring | Minimum operational tools and least-privilege proof. | Allowed operations work and forbidden normal Production operations are unavailable. |
| 5 — Environment Skeleton & Security Proof | Reproducible Local, protected Staging, locked Production skeleton, backup storage policy, and fail-closed checks. | A normal Staging workflow cannot be routed to Production. |
| 6 — CI, Review & Release Conveyor | Branch-to-Staging flow using a trivial reversible test change. | A green workflow reaches Staging while Production remains untouched. |
| 7 — Backup & Recovery Rehearsal | Synthetic backup, integrity, isolated restore, validation, cleanup, and retention behavior. | Backup existence and restore capability are proven. |
| 8 — Owner/Agent Dry Run | Fresh-agent bounded task and safe simulations of cost, Production, and scope stops. | The agent completes normal work autonomously and stops correctly at owner boundaries. |

The authoritative detail and Ready-to-Code Gate are in the [approved operating-system design](../superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md).

## Phase Brief contract

Store approved Phase Briefs under `briefs/`. A brief is an owner-approved phase
package, not a task note or a roadmap item. It MUST contain these sections:

1. **Goal** — bounded technical objective.
2. **Business Outcome** — owner-facing result and value.
3. **Authoritative Docs** — documents that govern the work.
4. **Included** — work inside the approval.
5. **Excluded** — explicit non-goals and prohibited expansion.
6. **External Effects** — allowed mutations or external interactions.
7. **Environments** — permitted Local, CI, Staging, or Production scope.
8. **Reviews** — independent and risk-triggered reviews required.
9. **Tests** — verification required before completion.
10. **DoD** — factual definition of done and evidence required.
11. **Stops** — applicable `REPAIR`, `BLOCKED`, and owner-decision boundaries.
12. **Owner Decisions** — decisions already resolved for the phase.
13. **Owner Actions** — actions the owner must perform, if any.
14. **Recovery** — ledger, rollback, and recovery expectations.

A brief must not grant a later phase, change the product boundary, or override
[Stop Conditions](../governance/STOP_CONDITIONS.md).

## Expected product roadmap

After the Ready-to-Code Gate, the expected direction is:

1. Data Model & Owner Admin Foundation
2. Recommendation Engine
3. Public Builder
4. Content & Monetization Layer
5. Staging Hardening
6. Production Launch

This is roadmap direction only. Each item requires its own separately approved
Phase Brief before any implementation starts.
