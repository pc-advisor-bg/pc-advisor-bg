# 0004 — Production Isolation

**Status:** Accepted

## Context

Autonomous Local and Staging work must not create normal-agent Production
mutation capability.

## Decision

Keep Production credentials and mutation paths isolated from normal coding
agents and CI; a merge to `main` is not a Production deployment.

## Consequences

The credential, deployment, and stop policy is authoritative in [Stop Conditions](../governance/STOP_CONDITIONS.md).

## Reversal condition

Any Production capability, deployment, migration, or credential change requires
explicit owner approval through the Production stop boundary.
