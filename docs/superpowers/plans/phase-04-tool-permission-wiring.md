# Phase 4 — Tool & Permission Wiring Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development`. Permission changes are security-sensitive and require verification of actual capability.

**Goal:** Connect only the minimum approved operational tools and prove least privilege, especially absence of normal Production mutation capability.

**Architecture:** GitHub is repo-scoped operational access. Supabase is Local/Staging only. Cloudflare agent credentials are Staging-scoped. One browser stack is selected. Sentry, if activated, is read-only.

**Tech Stack:** GitHub integration, Supabase tooling/MCP, Cloudflare scoped tooling/token, Playwright as first browser candidate, optional Sentry read-only, Context7/current official docs.

**Spec:** `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`

## Global Constraints

- Tool availability is not authorization.
- No Production Supabase MCP.
- No Production DB credential in agent/CI.
- No Production Cloudflare deploy token in agent/CI.
- No broad org/billing ownership permission.
- Firecrawl not permanent.
- Exactly one primary browser automation stack.

### Task 1: Inventory actual capabilities

**Files:**
- Modify: `docs/governance/TOOL_POLICY.md`
- Modify: `docs/infrastructure/SECRETS.md`

- [ ] Enumerate connected GitHub, Supabase, Cloudflare, browser, Sentry, documentation tools.
- [ ] Record capability/scope only, not token values.
- [ ] Compare actual access against policy.
- [ ] Unexpected broad Production capability is a blocker until removed.

### Task 2: GitHub operational access proof

- [ ] Scope access to PC Advisor resources as narrowly as current integration supports.
- [ ] Verify repository/history read.
- [ ] Verify test branch create/push.
- [ ] Verify PR create/update/read.
- [ ] Verify CI status read.
- [ ] Verify merge capability obeys branch rules.
- [ ] Verify private Project draft-item access.
- [ ] Verify approved workflow does not grant org-owner/billing/repo-visibility/collaborator authority.
- [ ] Remove harmless test branch after proof.

### Task 3: Supabase Local + Staging only

- [ ] Configure local Supabase CLI/tooling.
- [ ] Configure Staging project-scoped access.
- [ ] Permit only approved DB/debug/development/docs capabilities.
- [ ] Do not configure Production.
- [ ] Prove Staging identity using a safe read-only metadata query.
- [ ] Search normal agent config for Production project access; expected absent.
- [ ] A Production tool call without credentials must fail/unavailable rather than succeed.

### Task 4: Cloudflare Staging credential

- [ ] Owner creates least-privilege Staging-scoped token using current official permissions.
- [ ] Raw token goes directly to Bitwarden.
- [ ] Owner inserts it into approved GitHub Secret/tool config without chat exposure.
- [ ] Verify intended Staging access.
- [ ] Verify no Production deploy token in normal GitHub/agent environment.
- [ ] Verify Global API Key is not used.

### Task 5: Select one browser stack

**Files:**
- Create: `docs/decisions/0012-browser-verification-stack.md`

- [ ] Verify current Playwright support for pinned Node, selected Next.js path, Windows, CI, screenshots/traces, and protected Staging access.
- [ ] If all hard requirements pass, select Playwright.
- [ ] Only if a hard requirement fails, evaluate one approved alternative and record the concrete failure/reason.
- [ ] Record exactly one selected browser stack.
- [ ] Do not keep a second overlapping stack.

### Task 6: Sentry boundary

- [ ] If activated at €0, configure only read diagnostics required to inspect issues/events.
- [ ] If activation requires spend, defer and report `OWNER DECISION REQUIRED` only if the phase cannot proceed without it.
- [ ] Sentry must not become a build dependency.
- [ ] No Sentry write/admin capability for normal coding agent.

### Task 7: Research/documentation boundary

- [ ] Permit Context7/current official docs for library/API verification.
- [ ] Mark Firecrawl `disabled by default; approved research/content phase only`.
- [ ] Keep Notion, Linear, extra trackers, and overlapping browser tools outside permanent stack.

### Task 8: Permission matrix review

- [ ] GitHub allowed actions succeed.
- [ ] Supabase Staging allowed actions succeed.
- [ ] Cloudflare Staging allowed actions succeed.
- [ ] Browser launches locally.
- [ ] Production Supabase access absent.
- [ ] Production Cloudflare deploy credential absent.
- [ ] Production backup reader absent from agent/CI.
- [ ] Independent security reviewer confirms least privilege.

### Task 9: Phase 4 gate

- [ ] Minimal toolset only.
- [ ] GitHub operational access works.
- [ ] Supabase Local/Staging works.
- [ ] Production Supabase MCP absent.
- [ ] Cloudflare Staging credential works.
- [ ] Production deploy credential absent.
- [ ] One browser stack selected.
- [ ] Sentry read-only or safely deferred.
- [ ] Firecrawl not permanently enabled.
- [ ] Security review green.

Stop. Do not activate Phase 5 automatically.
