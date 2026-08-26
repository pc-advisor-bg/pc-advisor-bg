# Cloudflare Infrastructure

## Purpose

This document is the authoritative technical policy for Cloudflare environment separation, access controls, tokens, and backup storage. It does not authorize account, deployment, DNS, Access, R2, or token mutation.

## Account and environment separation

- A separate Cloudflare account using the project identity isolates PC Advisor BG from unrelated projects.
- Staging and Production use separate application targets, URLs, credentials, and deployment paths.
- Staging is the autonomous hosted verification environment: it is protected by Cloudflare Access, marked `noindex`, and usable by the approved browser-verification method.
- Production has no normal agent or normal CI deployment token. Release requires explicit owner approval of the exact verified candidate.
- Before any permitted hosted deployment, prove repository, branch, exact SHA, declared environment, Supabase project reference, and Cloudflare target. Failure to prove identity fails closed.

The exact supported stable Next.js-to-Cloudflare deployment path is selected and pinned only during an authorized setup phase after current official-support verification. Selecting or configuring it is not authorized by this documentation phase.

## Token policy

- Use scoped API tokens only; a Global Cloudflare API Key is forbidden.
- Scope every token to its required account, target, operation, and environment. Do not reuse Staging credentials for Production.
- Store tokens outside Git and grant them only to the authorized consumer defined in [SECRETS.md](SECRETS.md).
- The normal coding agent, normal CI, and browser code receive no Production Cloudflare deployment token.

Requests that expand scope, grant Production authority, add a second hosting provider, or activate paid resources stop under [STOP_CONDITIONS.md](../governance/STOP_CONDITIONS.md).

## R2 backup storage

Private R2 is the approved destination for encrypted backup archives.

- Admin Publish snapshots use an approved private Production-runtime binding, not a general R2 API credential exposed to the normal coding agent.
- Full release backups use the controlled backup flow in [BACKUP_AND_RESTORE.md](BACKUP_AND_RESTORE.md).
- R2 objects, account identifiers, credentials, and backup material remain private and are never committed.

## Related authorities

- [TOOL_POLICY.md](../governance/TOOL_POLICY.md) — external-tool and Production-access boundary.
- [SECRETS.md](SECRETS.md) — symbolic secret inventory and storage requirements.
- [BACKUP_AND_RESTORE.md](BACKUP_AND_RESTORE.md) — retention, encryption, and restore rehearsal.