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
| GitHub | GitHub CLI is authenticated through the system keyring and reports `gist`, `read:org`, `read:project`, `repo`, and `workflow` scopes. The exposed tool registry also provides GitHub mutation interfaces. | `repo`, `workflow`, and Project-read support the approved category only after Task 2 proves effective PC Advisor BG limits. `gist` is an unapproved excess capability and must remain unused. Scope labels and exposed interfaces do not prove a resource-level repository boundary or effective organization authority. | Task 2 must prove the permitted project path and effective limits, or leave the unrelated global integration unused without modifying it. |
| Supabase | No local Supabase CLI or related environment variable is present. The exposed tool registry provides deferred Supabase MCP interfaces. | Tool exposure does not prove authentication, Local/Staging target identity, effective permissions, or absence of a Production connection. | Task 3 may establish and verify only Local and separately identified Staging access. |
| Cloudflare | No local Wrangler CLI is installed. An active bearer API token is present in the normal agent environment, and the exposed tool registry provides Cloudflare API execution, search, and documentation interfaces. No Global API Key environment variable was observed. | Token presence and tool exposure do not prove account, resource, environment, operation scope, or the required Staging-only boundary. | Task 4 must verify the approved Staging capability and absence of a normal Production deployment token without exposing identifiers or values. |
| Browser verification | Google Chrome is installed. No local Playwright CLI or dependency is present. The exposed tool registry provides a Playwright browser interface and a separate overlapping MCP_DOCKER browser surface; neither is selected. | Available-but-unselected overlapping browser surfaces do not satisfy the exactly-one-primary-stack rule and must not be disabled or selected by this task. | Task 5 evaluates Playwright first and records exactly one selected stack. |
| Sentry | No Sentry CLI, connected Sentry integration, or Sentry-related environment variable is available in this session. | Read-only diagnostics are not activated; no Sentry write/admin capability is available to this agent session. | Task 6 may safely defer or configure only approved read diagnostics. |
| Documentation | Official documentation can be retrieved through the agent's read-only web capability. The exposed tool registry provides a deferred Context7 interface. | Current official documentation is available as approved. Context7 exposure does not establish authentication or a permanent connection. | Task 7 records the research/documentation boundary and keeps non-approved tools disabled. |

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
