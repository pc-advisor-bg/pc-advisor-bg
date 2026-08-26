# Stop Conditions

## Purpose

This document is the authoritative decision classifier for conditions that alter normal autonomous execution.

## Operational states

### REPAIR

A technical problem is inside the approved Phase Brief and has an engineering path that does not require an owner or boundary decision.

Continue autonomously: diagnose, make the smallest justified repair, perform required review, rerun relevant verification, and update the recovery ledger.

### BLOCKED

A proven dependency, access boundary, or external condition prevents progress and cannot be resolved within approved autonomy.

Preserve the factual state, avoid speculative workarounds, update the recovery ledger, and report the blocker with the evidence, impact, and next authorized action.

### OWNER DECISION REQUIRED

A decision is required in an owner-controlled category or the required choice is genuinely unresolved.

Stop before mutation, preserve state, and present one concrete decision with the practical consequence of each relevant outcome. Do not ask an unbounded question.

## Stop before these actions

Owner approval is mandatory before:

- Activating or increasing paid spend, a paid add-on, a non-zero recurring resource, or an automatic paid upgrade.
- Any Production deployment, Production migration, destructive Production action, or normal-agent Production credential use.
- A destructive external action outside the active Phase Brief.
- Accessing real user data beyond explicitly approved operational access.
- A legal, commercial, affiliate-policy, licensing, repository-visibility, or account-ownership decision.
- Adding or changing an architecture-affecting service or provider.
- Expanding the approved Phase Brief, product boundary, or authorized environment.
- Weakening branch protections, required checks, tests, security controls, or access boundaries.
- A genuine unresolved blocker requiring a business or owner choice.

## Production boundary

Production is a separate security boundary. The normal coding agent has no Production database mutation credential, Production migration credential, Production Supabase MCP, normal Production Cloudflare deployment token, Production backup reader, or owner recovery credential.

A missing credential is a correct security result, not a defect to bypass.

Merging `main` does not authorize or deploy Production. Production promotion requires the owner's explicit approval of the exact verified candidate.

## Cost boundary

The launch target is €0 mandatory recurring infrastructure cost wherever reasonably safe.

Tool discovery, a free-tier limit, or a technically attractive service does not authorize cost, billing, or a provider expansion.

## Scope boundary

Discovery is not authorization. Record future ideas in the private Parking Lot without modifying the active plan or implementation.

Phase completion does not activate a future phase.

## Escalation packet

An `OWNER DECISION REQUIRED` report contains:

1. The concrete decision needed.
2. The evidence that makes the decision necessary.
3. The affected scope, cost, environment, or risk.
4. The safe state preserved while waiting.
5. The next action that becomes authorized after the decision.

Use [REPORTING_STANDARD.md](REPORTING_STANDARD.md) for the owner-facing format.