# 0005 — No External AI in V1

**Status:** Accepted

## Context

V1 recommendations must remain deterministic, cost-controlled, and independent
of an external AI runtime.

## Decision

Do not use an external AI runtime in V1; AI does not select hardware.

## Consequences

The V1 product boundary and exclusions are authoritative in [Project Charter](../governance/PROJECT_CHARTER.md).

## Reversal condition

An external AI capability requires a later owner-approved Phase Brief that
changes the product boundary and resolves the related cost and scope decisions.
