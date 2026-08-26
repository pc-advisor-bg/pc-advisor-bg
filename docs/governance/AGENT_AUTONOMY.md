# Agent Autonomy

## Purpose

This document is the authoritative boundary for work the normal coding agent may perform without a new owner approval.

## Preconditions for autonomous work

Autonomy exists only inside an owner-approved active Phase Brief.

The agent identifies the approved Phase Brief before changing code or infrastructure.

The agent completes the task preflight required by [AGENTS.md](../../AGENTS.md), including proven hosted target identity where applicable.

The agent follows the Superpowers methodology and the active task's required reviews and verification.

## Authorized work inside an approved Phase Brief

The agent may perform these actions without repetitive owner authorization when they remain within the approved brief:

- Create task branches and make focused changes.
- Develop testable behavior through TDD.
- Commit, push, open, and update pull requests.
- Run CI, tests, diagnostics, reviews, and browser or end-to-end verification.
- Diagnose and repair reproducible engineering defects.
- Use approved Local resources.
- Use approved Staging resources, including safe non-destructive migrations and Staging deployments.
- Repeat diagnostics when a repair, new hypothesis, recovered transient dependency, or changed precondition justifies the retry.
- Auto-merge a fully green task when the approved flow permits it.
- Continue to the next approved task in the same phase.
- Update the private Project and the recovery ledger.

## Repair autonomy

A failed test, build, CI job, Staging defect, browser race, or reproducible engineering defect is normal engineering work.

When its repair stays within the approved Phase Brief, the agent diagnoses, repairs, reviews, and reruns it autonomously.

An identical failed action is never repeated without a concrete reason: a repair, diagnostic hypothesis, recovered transient dependency, or changed precondition.

## Boundaries retained by the owner

The owner retains every decision listed in [STOP_CONDITIONS.md](STOP_CONDITIONS.md), including money, Production, destructive, legal, commercial, account, and scope-expansion authority.

Credentials must enforce the Production boundary; policy text is not a substitute for credential separation.

## Recovery ledger contract

Every execution phase maintains this factual recovery ledger:

```text
.superpowers/sdd/<phase>/progress.md
```

Update it at meaningful task checkpoints and before handing off or reporting a blocker.

The ledger records only recovery facts:

| Field | Required content |
| --- | --- |
| Current phase | Active phase identifier and name |
| Current task | Active task identifier and concise status |
| Last verified SHA | Exact commit SHA tied to completed evidence |
| Checks | Completed checks and their result markers |
| PR | Current pull-request reference, or `none` |
| Blocker | Current proven blocker, or `none` |
| Next authorized action | The next action permitted by the active Phase Brief |
| Staging state | Target identity and current verification or deployment state |

A new session recovers from Git, the private Project, this ledger, and authoritative phase documents. It does not repeat completed work merely because chat context changed.

## Related authorities

- [PROJECT_CHARTER.md](PROJECT_CHARTER.md) defines product boundary and exclusions.
- [STOP_CONDITIONS.md](STOP_CONDITIONS.md) defines when autonomy stops.
- [TOOL_POLICY.md](TOOL_POLICY.md) defines permitted permanent tools and environment capability limits.
- [REPORTING_STANDARD.md](REPORTING_STANDARD.md) defines owner communication.