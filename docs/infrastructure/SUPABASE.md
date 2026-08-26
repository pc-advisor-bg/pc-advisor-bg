# Supabase Infrastructure

## Purpose

This document is the authoritative technical policy for Supabase environments and authorization. It defines environment separation and credential limits; it does not authorize a provider connection, configuration, migration, or deployment.

## Environment model

| Environment | Intended use | Required boundary |
| --- | --- | --- |
| Local | Reproducible application state, local Supabase/Postgres, synthetic data, and local environment values. | No Production credential is needed; state comes from migrations and approved seeds or fixtures. |
| Staging | Autonomous hosted verification. | Separate project, database, Auth identities, credentials, and no real Production data. Hosted use requires target-identity preflight. |
| Production | Public operating environment. | Locked owner-controlled security boundary; normal coding agent and CI do not receive its administration, migration, service-role, or MCP access. |

Both hosted projects are independently owned project resources. The approved design identifies Frankfurt / `eu-central-1`; actual project references remain private and are never committed.

Before any permitted hosted operation, prove repository, branch, exact SHA, declared environment, Supabase project reference, and Cloudflare target. Contradictory or unproven identity fails closed under [TOOL_POLICY.md](../governance/TOOL_POLICY.md).

## Auth and data authorization

- Supabase Auth serves the single owner Admin account in V1; public registration is disabled.
- Successful authentication alone is not authorization. The authenticated identity must match the explicitly authorized owner.
- Authorization must not rely on mutable user-controlled metadata.
- Apply Row Level Security (RLS) wherever an exposed table requires it, and verify authorization behavior with the relevant security and data-integrity review.
- Do not enable Realtime, Storage, Edge Functions, branching, or extra Supabase products unless a later owner-approved phase proves a requirement.

## Credential boundary

- Browser code never receives service-role or secret credentials.
- Production applications avoid service-role credentials by default. A Production service-role dependency requires an approved requirement and security review.
- A Production Supabase MCP connection is not configured and must not be introduced.
- Staging tooling, when authorized by a later Phase Brief, is project-scoped and limited to the approved capability.
- Normal CI may receive only narrowly scoped Staging secrets when an approved phase requires them; it receives no Production database administration, migration, service-role, or secret credentials.

A missing Production credential is the intended security control, not a defect. Requests for Production access stop under [STOP_CONDITIONS.md](../governance/STOP_CONDITIONS.md). Symbolic inventory and storage rules are in [SECRETS.md](SECRETS.md).

## Related authorities

- [TOOL_POLICY.md](../governance/TOOL_POLICY.md) — tool and hosted-operation policy.
- [AGENT_AUTONOMY.md](../governance/AGENT_AUTONOMY.md) — approved Local and Staging work.
- [BACKUP_AND_RESTORE.md](BACKUP_AND_RESTORE.md) — Production backup and restore boundary.