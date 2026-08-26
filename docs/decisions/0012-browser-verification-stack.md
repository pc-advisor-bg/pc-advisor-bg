# ADR 0012: Playwright as the primary browser verification stack

- Status: Accepted
- Date: 2026-08-26
- Governing authority: `docs/governance/TOOL_POLICY.md`

## Context

Phase 4 requires exactly one primary browser verification stack for local,
protected Staging, and CI verification. The selection must work on Windows,
support reliable automation and diagnostics, avoid extra infrastructure, and
remain compatible with the future Next.js application path.

## Decision

Use the exposed **Playwright** browser integration as the only primary browser
verification stack. When application test dependencies are introduced in an
approved future task, use the Playwright Test package and pin its version in
the project lockfile.

Do not select, install, or retain a second overlapping browser stack. The
separately exposed MCP_DOCKER browser surface remains unselected and is not
modified by this decision.

## Evidence

- The Playwright integration launched successfully on this Windows host,
  navigated to a public smoke-test page, and produced a full-page screenshot.
- Current official Playwright documentation supports CI execution, Windows
  browser installation, and trace/screenshot diagnostics.
- Playwright Test is framework-agnostic and can exercise a protected Staging
  URL once the approved application and access route exist; no Staging login
  or application target was created in Phase 4.

## Consequences

- Browser verification artifacts must be treated as potentially sensitive and
  retained only in approved local or CI artifact storage.
- CI configuration and a pinned Playwright dependency are deferred until an
  approved application-testing task; this ADR does not authorize product
  coding, CI workflow changes, or Staging deployment.
- A replacement stack requires a proven hard requirement failure and owner
  approval under the tool policy.

## Reversal condition

Reconsider only if Playwright fails a documented hard requirement for the
approved application path, Windows, CI, protected Staging verification, or
required diagnostics, and the owner approves the resulting scope change.