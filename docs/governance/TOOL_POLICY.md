# Tool Policy

## Purpose

This document is the authoritative policy for the minimal permanent toolset and the capability boundaries attached to it.

Tool availability is not permission to expand scope.

## Permanent approved categories

| Category | Approved use |
| --- | --- |
| Superpowers | The only software-development methodology |
| GitHub | Approved repository, pull-request, CI, and private Project operations |
| Supabase | Local and approved Staging only |
| Cloudflare | Approved Staging and infrastructure operations |
| Browser verification | One selected primary verification implementation |
| Sentry | Read-only diagnostics when monitoring is activated |
| Context7 and official documentation | Current library and API verification |

## Tool selection boundaries

Exactly one primary browser verification stack is installed.

During Tool Wiring, the bounded selection must satisfy real end-to-end support, Windows and CI compatibility, stable automation, diagnostics or screenshots, minimal extra infrastructure, and framework compatibility.

A second overlapping browser stack requires a proven need and owner-approved scope expansion.

Firecrawl may be enabled only for a specifically approved research or content phase; it is not permanent coding tooling.

Notion, Linear, overlapping browser stacks, extra trackers, and other tools are outside the normal operating system until explicitly approved.

## Environment capability boundary

Supabase and Cloudflare references in this document describe policy only; they authorize no provider mutation by themselves.

Local uses reproducible application state, local Supabase/Postgres, synthetic data, and local environment values.

Staging is the autonomous hosted verification environment. It is a separately identified target with no real Production data, protected access, and `noindex` where applicable.

Normal CI may receive narrowly scoped Staging secrets only where an approved phase requires them.

## Phase 4 capability inventory — 2026-08-26

This is a read-only capability snapshot for the normal agent environment. It
records no token values, provider identifiers, account names, or recovery
material. Availability does not grant permission and this snapshot does not
replace hosted-operation preflight.

| Category | Observed capability/scope | Policy comparison | Follow-up |
| --- | --- | --- | --- |
| GitHub | GitHub CLI is authenticated through the system keyring. Its reported scopes are `gist`, `read:org`, `read:project`, `repo`, and `workflow`. | Supports repository, pull-request, CI, and private Project operations. The scope readout alone cannot prove resource-level repository restriction or effective organization authority. It does not report an organization-owner or billing scope. | Task 2 must prove the permitted operations and their effective limits on PC Advisor BG resources. |
| Supabase | No Supabase CLI, Supabase MCP connection, or Supabase-related environment variable was available to this normal agent session. | No Local or Staging provider capability has yet been proven; no Production connection is configured in this session. | Task 3 may add and verify only Local and separately identified Staging access. |
| Cloudflare | No Wrangler CLI is installed. An active bearer API token is present in the normal agent environment; its account, resource, environment, and operation scope were not disclosed by the read-only token-validity check. No Global API Key environment variable was observed. | Active-token presence alone does not prove the required Staging-only boundary. There is no evidence here of Production authority, but the boundary remains unproven until scope and target are checked. | Task 4 must verify the approved Staging capability and absence of a normal Production deployment token without exposing identifiers or values. |
| Browser verification | Google Chrome is installed. No Playwright CLI or local Playwright dependency is present, and no browser-verification stack is selected yet. | Does not yet satisfy the exactly-one-primary-stack rule. | Task 5 evaluates Playwright first and records one selected stack. |
| Sentry | No Sentry CLI, connected Sentry integration, or Sentry-related environment variable is available in this session. | Read-only diagnostics are not activated; no Sentry write/admin capability is available to this agent session. | Task 6 may safely defer or configure only approved read diagnostics. |
| Documentation | Official documentation can be retrieved through the agent's read-only web capability. No Context7 connection is available in this session. | Current official documentation is available as approved; Context7 is not a required permanent connection. | Task 7 records the research/documentation boundary and keeps non-approved tools disabled. |

### Inventory decision boundary

- This inventory intentionally does not configure a provider, alter a credential,
  or access a hosted project or account resource.
- An observed broad Production capability is a `BLOCKED` condition until it is
  removed. No such capability was proven by this read-only snapshot.
- An unproven scope is not treated as permission. The task named in the
  follow-up column must establish its own target-specific evidence before use.

## Forbidden normal-agent Production access

The normal coding agent and normal CI must not possess or use:

- Production database administration, migration, or service-role credentials.
- A Production Supabase MCP connection.
- A normal Production Cloudflare deployment token.
- Bitwarden or owner recovery credentials.
- A Production backup reader or backup encryption master material.
- A Global Cloudflare API Key.

A Production capability request follows [STOP_CONDITIONS.md](STOP_CONDITIONS.md); it is never solved by adding credentials to source, CI, agent configuration, or browser code.

## Hosted-operation preflight

Before a hosted migration or deployment, prove the applicable target identity:

- Repository and branch.
- Exact SHA.
- Declared environment.
- Supabase project reference.
- Cloudflare target.

Contradictory or unproven target identity fails closed.

## Safe handling

Use symbolic placeholders in public documentation and configuration templates.

Store secrets outside Git and limit them to their authorized consumer.

If a secret may have leaked, stop normal work long enough to follow the approved containment sequence: revoke, replace, determine exposure, verify, and document.
