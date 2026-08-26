# Staging Operations

## Purpose

Staging is the autonomous hosted verification environment. This document defines its intended operational boundary only; it does not authorize provider access, configuration, migration, or deployment during Phase 3.

The authoritative environment and credential policy is [Tool Policy](../governance/TOOL_POLICY.md). Supabase and Cloudflare-specific constraints remain in [Supabase Infrastructure](../infrastructure/SUPABASE.md) and [Cloudflare Infrastructure](../infrastructure/CLOUDFLARE.md).

## Isolation and data rule

Staging has its own Supabase project, database, Auth identities, Cloudflare target, URL, and narrowly scoped credentials. It is protected by Cloudflare Access and marked `noindex`.

Staging contains only synthetic, approved test data. It must never receive real Production data, owner recovery material, or Production secrets. Production data is not copied into permanent Staging, including during restore rehearsal.

## Autonomous use

Inside an active owner-approved Phase Brief, the agent may use the approved Staging target for safe verification, browser checks, non-destructive migrations, and deployment when the brief authorizes those effects. Browser automation uses a machine/service method, not the owner's personal login.

Before any permitted hosted migration or deployment, prove repository, branch, exact SHA, declared environment, Supabase project reference, and Cloudflare target. Unproven or contradictory identity fails closed. Do not substitute an accessible target or compensate for missing access with a broader credential.

## What Staging does not prove

A passing Staging check is evidence for that separately identified Staging target only. It does not prove a Production deployment, Production database state, backup health, or owner approval. The Production candidate and approval gate are defined in [Production Release](PRODUCTION_RELEASE.md).

## Boundaries

- Staging credentials are not reusable for Production.
- Normal CI may use only the narrowly scoped Staging secrets that a later approved phase requires.
- The normal agent and normal CI receive no Production database, migration, service-role, Cloudflare deploy, backup-reader, or recovery credentials.
- Phase 4 Tool and Permission Wiring is not authorized by this document or Phase 3.

Use [Stop Conditions](../governance/STOP_CONDITIONS.md) for Production, cost, account, scope, legal, commercial, or destructive decisions.
