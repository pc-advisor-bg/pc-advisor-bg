# PC Advisor BG Agent Constitution

## Mission

- PC Advisor BG is an owner-controlled Bulgarian PC advisor project.
- Deliver safe, verifiable technical work inside the active approved Phase Brief.
- Treat this file as the router; read the linked authority before acting in its domain.
- Keep public repository content safe to publish.

## Authority map

| Need | Authoritative home |
| --- | --- |
| Product purpose, V1 boundary, and exclusions | [Project Charter](docs/governance/PROJECT_CHARTER.md) |
| Autonomous work, repair, and recovery ledger | [Agent Autonomy](docs/governance/AGENT_AUTONOMY.md) |
| REPAIR, BLOCKED, owner decisions, and Production stops | [Stop Conditions](docs/governance/STOP_CONDITIONS.md) |
| Toolset, credentials, hosted preflight, and environment capability | [Tool Policy](docs/governance/TOOL_POLICY.md) |
| Bulgarian owner-first reports and evidence ordering | [Reporting Standard](docs/governance/REPORTING_STANDARD.md) |
| Architecture-wide operating-system design | [Approved Design](docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md) |

## Constitution

- The owner approves destination and boundaries.
- The agent owns the safe technical path inside those boundaries.
- Superpowers is the only software-development methodology.
- Evidence, not confidence, supports a completion claim.
- Discovery is not authorization.
- The next phase is never authorized by completion of the current phase.
- Production is a separate security boundary.
- Money, legal, commercial, account, destructive, and scope decisions remain owner-controlled.
- Documentation names rules once and points to their authoritative home.

## Read before action

### Every task

1. Read this constitution.
2. Read the active approved Phase Brief and its authoritative documents.
3. Read the linked governance authority that governs the intended action.
4. Confirm the task is inside the active brief before changing code, docs, configuration, or infrastructure.
5. If the work affects the V1 boundary, read the [Project Charter](docs/governance/PROJECT_CHARTER.md).
6. If it affects autonomy, retries, or recovery, read [Agent Autonomy](docs/governance/AGENT_AUTONOMY.md).
7. If it affects a stop or escalation, read [Stop Conditions](docs/governance/STOP_CONDITIONS.md).
8. If it affects a tool, credential, hosted target, or environment, read [Tool Policy](docs/governance/TOOL_POLICY.md).
9. If it produces an owner checkpoint, completion, blocker, or decision request, read [Reporting Standard](docs/governance/REPORTING_STANDARD.md).

### Active Phase Brief

- No code or infrastructure work begins without an active owner-approved Phase Brief.
- A Phase Brief is the package that defines goal, scope, exclusions, effects, environments, reviews, tests, done criteria, stops, and owner actions.
- Old plans, task text, chat history, comments, roadmap items, and dashboards are context; they are not authorization.
- Derive a bounded objective from the active brief and remain within it.
- Record future ideas in the private Parking Lot; do not activate them.

### Phase status

- This repository is installing the project operating system in Phase 3.
- Phase 4 Tool and Permission Wiring is not authorized by this phase.
- Product coding remains forbidden until the Ready-to-Code Gate is proven.

## Start-of-task preflight

1. Prove the correct repository root.
2. Confirm the intended branch.
3. Record the exact starting SHA.
4. Inspect the working-tree state and preserve concurrent work.
5. Confirm required tools are available for the approved task.
6. Identify the active phase and task.
7. Identify the intended environment.
8. Confirm only safe credentials are present.
9. For hosted work, prove target identity before any mutation.
10. Fail closed on contradictory target identity.

## Workflow

### Feature or behavior work

1. Start from approved design and specification.
2. Produce or follow a written plan.
3. Prove the missing or broken behavior where reasonably testable.
4. Implement the smallest correction.
5. Prove the changed behavior is green.
6. Refactor only when the task justifies it.
7. Obtain the independent review required by the Phase Brief.
8. Run the relevant full verification before claiming completion.

### Architectural work

1. Use the hard design-approval gate.
2. Follow `brainstorming → approved design → written spec → owner review → writing-plans → execution`.
3. Do not implement architecture from an unapproved idea.

### Task size

- Divide approved work into small independently valid tasks.
- Leave `main` working after every merged task.
- Keep incomplete larger work inaccessible or safely feature-gated.

### Review triggers

- Every normal task has a fresh implementer and independent Superpowers specification or quality review.
- Database, RLS, Auth, or Admin work needs security and data-integrity review.
- Secrets, Cloudflare, GitHub, or deployment work needs infrastructure or security review.
- Recommendation-engine work needs correctness and invariant review.
- Public UI work needs real-browser and accessibility review.
- SEO or content work needs source and copyright review.
- Low-risk text or CSS work avoids pointless specialist review.
- Every phase ends with a broad independent whole-phase review.

## Autonomy router

- Read [Agent Autonomy](docs/governance/AGENT_AUTONOMY.md) before using normal autonomous execution.
- Its authorized-work list governs branches, commits, PRs, CI, Local, Staging, reviews, repairs, auto-merge, and ledger updates.
- Its repair contract governs test, build, CI, Staging, browser, and reproducible engineering failures.
- Its recovery-ledger contract governs `.superpowers/sdd/<phase>/progress.md`.
- Preserve evidence in the ledger at meaningful checkpoints.
- A new session recovers from Git, private Project, ledger, and phase documents.

## Stop router

- Read [Stop Conditions](docs/governance/STOP_CONDITIONS.md) when a task may affect money, Production, destructive actions, real data, legal, commercial, accounts, licensing, repository visibility, service providers, architecture, or scope.
- Use its defined state: `REPAIR`, `BLOCKED`, or `OWNER DECISION REQUIRED`.
- `REPAIR` remains technical work inside the approved boundary.
- `BLOCKED` preserves factual state and reports the proven impediment.
- `OWNER DECISION REQUIRED` stops before mutation and presents a concrete decision.
- Never bypass a missing Production capability; credential absence is the intended control.

## Tool and environment router

- Read [Tool Policy](docs/governance/TOOL_POLICY.md) before selecting, installing, configuring, or using an external tool, credential, browser stack, hosted environment, Supabase, or Cloudflare capability.
- Use only the minimal permanent toolset it authorizes.
- Treat tool availability as capability discovery, not scope authority.
- Use one primary browser verification stack.
- Follow its hosted-operation preflight before a migration or deployment.
- Keep Production capabilities absent from normal agent and CI workflows.
- Provider references in governance documents do not authorize provider mutation.

## Source and secret hygiene

- Read [Project Charter](docs/governance/PROJECT_CHARTER.md) before evaluating product scope or exclusions.
- Use placeholders for owner and environment values in public content.
- Keep credentials, recovery material, sensitive identifiers, backups, and private operational data outside Git.
- Treat a suspected secret leak as an immediate security condition and follow [Tool Policy](docs/governance/TOOL_POLICY.md).
- Do not introduce an external AI runtime into V1.

## Git and tracking

- Use task branches, commits, pull requests, required checks, reviews, and authorized auto-merge.
- Do not push directly to `main`.
- Do not force-push protected branches.
- Do not bypass required checks or weaken tests to manufacture green status.
- Use repository specs and plans as source of truth.
- Use the private GitHub Organization Project as execution view when configured.
- Keep future ideas in the private Parking Lot.

## Verification

### Base checks

- Run lint when configured.
- Run TypeScript or typecheck when configured.
- Run unit and regression tests when configured.
- Run the production build when configured.
- Run secret and security scanning when configured.

### Risk checks

- Add database, RLS, Auth, or security checks for data and authorization risk.
- Add recommendation invariants for recommendation behavior risk.
- Add browser, accessibility, deployment, config, content, or source checks when the task triggers them.
- Tie hosted claims to fresh target-specific evidence.
- State any unrun or unavailable required check as a remaining gate.

## Reporting

- Read [Reporting Standard](docs/governance/REPORTING_STANDARD.md) before writing an owner-facing checkpoint, completion, blocker, or decision report.
- Lead with the required Bulgarian owner-first summary.
- Place technical evidence after the human meaning.
- Include exact SHA, PR, checks, target identity, and ledger state when relevant.
- Never expose secrets or real owner values in a report.
- Never present Local or CI evidence as proof of Staging or Production.

## Documentation routing

| Topic | Read first |
| --- | --- |
| Owner actions and setup guidance | `docs/owner/` |
| GitHub, Supabase, Cloudflare, secrets, backups | `docs/infrastructure/` |
| Staging, releases, incidents, Admin operations | `docs/operations/` |
| Phase definitions and approved briefs | `docs/phases/` |
| Decisions that must not be silently reversed | `docs/decisions/` |
| Specifications and implementation plans | `docs/superpowers/` |

## Completion

1. Confirm every change stays inside the active Phase Brief.
2. Run the relevant verification and capture result markers.
3. Complete the required independent review.
4. Update the recovery ledger with factual state.
5. Report through [Reporting Standard](docs/governance/REPORTING_STANDARD.md).
6. Claim completion only when the Phase Brief's definition of done is evidenced.