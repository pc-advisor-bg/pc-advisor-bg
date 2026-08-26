# Reporting Standard

## Purpose

This document is the authoritative owner-facing reporting format for meaningful checkpoints, completions, blockers, and owner decisions.

Technical documentation is English. The required owner-first report body is Bulgarian so the owner receives product meaning before implementation detail.

## When to report

Report meaningful checkpoints rather than every terminal command.

Report immediately when work becomes `BLOCKED` or `OWNER DECISION REQUIRED` under [STOP_CONDITIONS.md](STOP_CONDITIONS.md).

A completion claim requires the evidence appropriate to the active Phase Brief.

## Required owner-first template

Use these headings in this order:

```text
## Какво се промени
<Plain-language result and product meaning.>

## Как доказахме
<Meaningful verification and outcome.>

## Твоето действие
<Няма | Само информация | Нужно решение | Спряно безопасно>

## Какво следва
<Next authorized step.>

## Състояние
<Phase and blocker state.>
```

Follow the Bulgarian owner summary with concise technical evidence as applicable:

- Exact verified SHA.
- Pull-request reference and status.
- Verification commands, check names, and result markers.
- Target environment and identity evidence.
- Relevant test counts or failure evidence.
- Recovery-ledger location and updated state.

## Status mapping

| Operational state | Required `Твоето действие` value | Reporting focus |
| --- | --- | --- |
| Normal progress or verified completion | `Няма` or `Само информация` | Result, evidence, next authorized work |
| `BLOCKED` | `Спряно безопасно` | Proven dependency, preserved state, unblocking condition |
| `OWNER DECISION REQUIRED` | `Нужно решение` | Concrete decision, impact, safe waiting state |

## Reporting constraints

Do not include secrets, real owner values, credentials, recovery material, or private operational data.

Do not imply that Local or CI evidence proves Staging or Production status.

Do not call work complete from confidence alone; name the evidence and any remaining gate.

Use the exact status terms defined by [STOP_CONDITIONS.md](STOP_CONDITIONS.md).