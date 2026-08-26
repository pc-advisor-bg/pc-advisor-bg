# 0009 — One V1 Repository

**Status:** Accepted

## Context

The V1 system needs one auditable delivery path rather than distributed code,
operations, and deployment ownership.

## Decision

Keep V1 code, Admin, recommendation engine, migrations, tests, documentation,
and deployment configuration in one repository.

## Consequences

Repository structure and forbidden expansion are authoritative in the [approved operating-system design](../superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md).

## Reversal condition

A second repository, microservice, or separate backend requires explicit owner
approval as an architecture and scope expansion.
