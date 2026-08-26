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