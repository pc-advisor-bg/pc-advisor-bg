# 0011 — Runtime Version Selection

**Status:** Accepted
**Date:** 2026-08-26
**Scope:** Phase 2 — Repository & Local Foundation

## Context

PC Advisor BG requires exact, reproducible Node.js and pnpm versions selected
from current official compatibility evidence. The project uses pnpm only and
must remain compatible with Next.js, Supabase CLI, and the approved Cloudflare
Workers toolchain without prematurely selecting the Phase 5 deployment adapter.

## Decision

- Node.js: `24.19.0`
- pnpm: `11.24.0`
- Windows version manager: existing `nvm-windows`
- Project Node pin: `.node-version`
- Project pnpm pin: `package.json#packageManager`
- `package.json#engines` records both exact selected versions.

## Evidence checked on 2026-08-26

- Node.js official releases identify Node 24.19.0 as the current LTS release.
- Current Next.js documentation requires Node.js 20.9 or later.
- Supabase CLI requires Node.js 20 or later when run as a project dependency.
- pnpm 11 requires Node.js 22 or later and explicitly supports Node.js 24.
- pnpm 12 is still a release candidate, so it is not selected.
- pnpm 11.24.0 is the current stable pnpm release.
- Cloudflare Wrangler supports Node.js Current, Active LTS, and Maintenance LTS
  and recommends using the latest LTS.
- Cloudflare Workers Builds currently defaults to Node.js 24.
- Cloudflare's exact Next.js deployment path remains a Phase 5 decision.
  Current candidates were checked only for runtime compatibility.

## Local environment ruling

The existing `nvm-windows` installation is an acceptable version manager, so
`fnm` is not installed.

A secondary WinGet Node 22 executable remains on PATH, but the active executable
is the NVM symlink. No Node installation or PATH entry is removed during
Phase 2 unless a proven runtime conflict requires repair.

## Consequences

- Local development and later CI must use Node.js 24.19.0.
- pnpm 11.24.0 is the only project package manager version.
- npm, yarn, and bun lockfiles are not accepted.
- Runtime upgrades require a deliberate future compatibility review.
- This decision does not authorize product code or select the Cloudflare
  deployment adapter.
