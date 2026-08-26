# Secrets Inventory and Handling

## Purpose

This document is the authoritative symbolic inventory for PC Advisor BG sensitive values. It enables least-privilege setup and rotation planning without recording real values, identifiers, recovery material, or credentials.

All entries below are symbolic names only. Store actual values outside Git in the owner-controlled Bitwarden project structure or the applicable provider's secure configuration. Do not place a value in source, `.env` committed to Git, browser code or output, screenshots, chat, public documentation, Issues, or Pull Requests.

## Symbolic inventory

| Symbolic name | Purpose | Storage | Authorized consumer | Rotation expectation |
| --- | --- | --- | --- | --- |
| `PROJECT_OWNER_EMAIL` | Placeholder for the dedicated project ownership and recovery identity. | Private Bitwarden resource inventory and provider account profile. | Owner only; never application or CI. | Update only after owner-controlled identity change; verify recovery records. |
| `STAGING_SUPABASE_PROJECT_REF` | Identifies the Staging Supabase target during approved target preflight. | Private resource inventory. | Approved Staging setup or automation only. | Replace when the Staging project is replaced; revalidate target identity. |
| `PRODUCTION_SUPABASE_PROJECT_REF` | Identifies the Production Supabase target for owner-controlled release confirmation. | Private resource inventory. | Owner-controlled release process only; not normal agent or CI. | Replace when the Production project is replaced; revalidate target identity. |
| `CLOUDFLARE_ACCOUNT_ID` | Identifies the isolated project Cloudflare account. | Private resource inventory. | Approved environment configuration only. | Replace if the account changes; update affected scoped-token configuration through an approved phase. |
| `STAGING_CLOUDFLARE_API_TOKEN` | Performs the minimal approved Staging Cloudflare operation. | Provider secret configuration or CI secret store, never Git. | Approved Staging automation only. | Rotate on suspected exposure, scope change, personnel/access change, or provider policy requirement. |
| `PRODUCTION_CLOUDFLARE_DEPLOY_TOKEN` | Owner-controlled Production deployment capability, if later provisioned. | Owner-controlled provider secret storage. | Explicit owner-approved Production release process only. | Rotate after each suspected exposure and whenever Production access changes; never provide to normal agent or CI. |
| `STAGING_SUPABASE_SERVICE_ROLE` | Reserved only if an approved requirement and security review prove a Staging service-role need. Not provisioned by default. | Provider secret configuration or CI secret store only if approved. | The specifically approved server-side Staging consumer only. | Rotate on exposure, scope change, or service-role lifecycle change. |
| `PRODUCTION_BACKUP_READER_CREDENTIAL` | Read-only Production logical-backup input before an approved release. | Owner-controlled backup record. | Approved owner-controlled release backup process only. | Rotate on exposure or access change; never provide to normal agent or CI. |
| `BACKUP_ENCRYPTION_MASTER_MATERIAL` | Encrypts and recovers full release backup archives. | Owner recovery and backup records only. | Owner-controlled backup and restore process only. | Rotate under a documented recovery plan after compromise or cryptographic lifecycle change. |

## Handling and incident response

- Every consumer receives only the smallest necessary capability and environment scope.
- Normal agent and CI workflows have no Bitwarden access, owner recovery material, Production backup reader, backup encryption master material, Production Supabase MCP, or Production database/service-role credentials.
- If a secret may have leaked, follow the authoritative containment sequence in [TOOL_POLICY.md](../governance/TOOL_POLICY.md): revoke, replace, determine exposure, verify, and document.
- Public Git history is treated as publicly obtainable. Removing a value from a later commit is not containment.

## Phase 4 observed capability boundary — 2026-08-26

The Task 1 read-only inventory observed the following capability boundary
without recording any value, identifier, account name, or token material:

| Area | Observed boundary | Required interpretation |
| --- | --- | --- |
| GitHub | The authenticated GitHub CLI token is held by the system keyring and reports repository, workflow, organization-read, project-read, and gist scopes. | Scope labels do not prove a resource-level repository boundary or effective organization authority; Task 2 must prove the permitted PC Advisor BG operations. |
| Supabase | No Supabase CLI, MCP connection, or related environment variable is available to the normal agent session. | No provider access is approved or implied. Task 3 may establish only Local and approved Staging capability. |
| Cloudflare | An active bearer API token is present in the normal agent environment, but its scope and target were not recorded. No Global API Key environment variable was observed. | Treat its Staging-only and least-privilege status as unproven until Task 4 supplies target-specific evidence. It must not be used for Production work. |
| Browser and Sentry | Chrome is locally available; no browser automation stack, Sentry CLI, Sentry integration, or Sentry-related environment variable is present. | Browser selection remains Task 5. Sentry remains unavailable or safely deferred pending Task 6. |
| Documentation | Read-only official-documentation retrieval is available; Context7 is not connected in this session. | Official documentation remains permitted. Connection availability does not authorize additional documentation or research tooling. |

An unexpected broad Production capability is a `BLOCKED` condition under
`STOP_CONDITIONS.md` until removed. This snapshot proved no such capability;
it also does not treat absent proof as a grant of access.

## Related authorities

- [TOOL_POLICY.md](../governance/TOOL_POLICY.md) — secure handling and Production capability boundary.
- [SUPABASE.md](SUPABASE.md) — Supabase authorization and service-role policy.
- [CLOUDFLARE.md](CLOUDFLARE.md) — scoped Cloudflare token policy.
- [BACKUP_AND_RESTORE.md](BACKUP_AND_RESTORE.md) — backup credential use.
