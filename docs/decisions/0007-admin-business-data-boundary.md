# 0007 — Admin Business-Data Boundary

**Status:** Accepted

## Context

The owner needs safe future business operations without turning Admin into an
infrastructure or credential control plane.

## Decision

Admin manages approved business data and its safe history, not infrastructure,
credentials, deployments, or provider accounts.

## Consequences

The permitted Admin boundary is authoritative in [Admin Operations](../operations/ADMIN_OPERATIONS_BG.md).

## Reversal condition

Adding infrastructure or account controls to Admin requires explicit owner
approval and a later architecture-approved Phase Brief.
