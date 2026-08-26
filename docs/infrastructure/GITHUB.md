# GitHub Infrastructure

## Purpose

This document is the authoritative technical policy for the PC Advisor BG GitHub Organization, repository workflow, and private execution tracking. It enables safe repository work without changing account ownership, visibility, billing, or Organization configuration.

## Ownership and public-source boundary

- The existing personal GitHub account remains the human owner identity.
- The dedicated PC Advisor BG GitHub Organization owns the single V1 repository.
- The repository is public from the start as **public source**, not open source: source is viewable, all rights are reserved, and V1 accepts no external contributions.
- Repository Issues and Discussions are disabled; Pull Requests remain enabled.
- Public repository content must be safe to publish. The secret-handling authority is [SECRETS.md](SECRETS.md).

## Delivery and tracking flow

Normal repository flow is:

```text
task branch → focused commit → push → Pull Request → required CI and review → merge
```

- `main` receives work through Pull Requests only; direct and force pushes are forbidden.
- Required checks, reviews, and branch protections are evidence controls and must not be bypassed or weakened.
- A merge to `main` is a verified candidate, not a Production deployment. The Production boundary is governed by [STOP_CONDITIONS.md](../governance/STOP_CONDITIONS.md).
- Specifications and plans remain the source of truth. The private GitHub Organization Project is the execution view because public Issues are disabled.
- Each task is a private Project draft item. Use the statuses `Backlog`, `Ready`, `In Progress`, `In Review`, `Blocked`, and `Done`; retain Phase, Priority, Risk, Owner, Task/Plan reference, PR, Target Environment, and Last Updated fields.
- Future ideas belong in the private Project Parking Lot and do not activate scope.

## Forbidden Organization and repository changes

The agent must not autonomously:

- add or remove Organization owners, collaborators, or repositories;
- change billing, repository visibility, licensing, or legal status;
- delete the repository;
- enable public Issues or Discussions;
- weaken branch rules, rulesets, required checks, or review requirements; or
- create a new external-contribution program.

These are owner-controlled boundaries. Classify a request through [STOP_CONDITIONS.md](../governance/STOP_CONDITIONS.md) before any mutation.

## Related authorities

- [PROJECT_CHARTER.md](../governance/PROJECT_CHARTER.md) — public-source and V1 boundary.
- [AGENT_AUTONOMY.md](../governance/AGENT_AUTONOMY.md) — work allowed in an approved Phase Brief.
- [TOOL_POLICY.md](../governance/TOOL_POLICY.md) — CI credential and hosted-operation limits.