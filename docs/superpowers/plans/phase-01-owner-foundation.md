# Phase 1 — Owner Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` for agent tasks. Ownership/recovery actions remain human-owned.

**Goal:** Establish isolated owner-controlled identities and provider accounts for PC Advisor BG without exposing master credentials to the coding agent.

**Architecture:** The owner creates and controls project identities/accounts. The agent guides one safe owner action at a time and records only non-sensitive verification facts. No repository or product code exists yet.

**Tech Stack:** Proton Mail, Bitwarden, GitHub Organization, Cloudflare account, Supabase account/Organization.

**Spec:** `docs/superpowers/specs/2026-08-26-pc-advisor-project-operating-system-design.md`

## Global Constraints

- Do not request passwords, recovery codes, API keys, DB passwords, or tokens in chat.
- Use the dedicated project Proton identity for project ownership/recovery.
- Reuse the existing Bitwarden account.
- Keep this project isolated from unrelated projects.
- Free plans only; no paid upgrade.
- No repository creation.
- No product code.
- No product data.

### Task 1: Establish the owner-action safety contract

**Files:** none yet.

**Produces:** a non-sensitive Phase 1 action ledger.

- [ ] Show the owner this rule in Bulgarian: `Не изпращай парола, recovery code, API key, database password или token в чата. Secret-ите се въвеждат директно в официалния сайт или Bitwarden.`
- [ ] Mark every provider action as `OWNER / ACCOUNT`.
- [ ] Record only provider, ownership confirmation, display name, region, and whether recovery is stored.
- [ ] Never record raw secret values.

### Task 2: Verify the project Proton identity

- [ ] Owner signs into the dedicated Proton account directly.
- [ ] Owner verifies mailbox access by receiving/sending a normal test or provider verification email.
- [ ] Owner stores/updates the Proton credential in Bitwarden under PC Advisor BG.
- [ ] Record only `PROJECT_OWNER_EMAIL = configured privately`.
- [ ] If recovery/access is unavailable, stop as `OWNER DECISION REQUIRED`; do not substitute a different email.

### Task 3: Establish Bitwarden project structure

- [ ] Owner creates `PC Advisor BG`.
- [ ] Create logical entries/categories for Owner Recovery, Project Email, GitHub, Supabase Local, Supabase Staging, Supabase Production, Hosting & Domains, Analytics & Monitoring, AI Provider reserved/unused, Affiliate Accounts, Recovery & Backup Records.
- [ ] Create secure note `PC Advisor BG — Resource Inventory`.
- [ ] The secure note may contain provider identifiers/project refs and recovery notes, but no value is copied to chat.
- [ ] Record only `Owner Vault ready: YES`.

### Task 4: Create dedicated GitHub Organization

- [ ] Owner signs into the existing personal GitHub account.
- [ ] Create one new Organization dedicated to PC Advisor BG.
- [ ] Use the project email as Organization contact/billing email where the current UI supports it.
- [ ] Select the zero-cost plan only.
- [ ] Owner remains Organization owner.
- [ ] Do not add the coding agent as Organization owner.
- [ ] Do not create the repository yet.
- [ ] Store Organization slug in the private resource inventory.

### Task 5: Create isolated Cloudflare account

- [ ] Owner creates/signs into a Cloudflare account owned by the project Proton identity.
- [ ] Remain on free/default services.
- [ ] Do not create a Global API Key workflow.
- [ ] Store Cloudflare account identifier privately.
- [ ] Public docs later use only `CLOUDFLARE_ACCOUNT_ID`.
- [ ] Do not buy a domain.

### Task 6: Create isolated Supabase account and Organization

- [ ] Owner creates/signs into a Supabase account owned by project Proton identity.
- [ ] Create one Organization for PC Advisor BG.
- [ ] Use free plan only.
- [ ] Verify current free capacity can host both required projects.
- [ ] If two required active projects cannot coexist at €0, stop as `OWNER DECISION REQUIRED`.
- [ ] Do not reuse any unrelated Supabase project.
- [ ] Do not enable unrelated Supabase products.

### Task 7: Create Staging Supabase project

- [ ] Create `pc-advisor-staging`.
- [ ] Select Frankfurt / `eu-central-1`.
- [ ] Generate/store DB password directly in Bitwarden.
- [ ] Store project ref privately.
- [ ] Verify project becomes healthy.
- [ ] Do not create product tables.

### Task 8: Create Production Supabase project

- [ ] Create `pc-advisor-production`.
- [ ] Select Frankfurt / `eu-central-1`.
- [ ] Generate/store DB password directly in Bitwarden.
- [ ] Store project ref privately.
- [ ] Verify project becomes healthy.
- [ ] Do not configure coding-agent MCP/tooling for this project.
- [ ] Do not create product tables or real data.

### Task 9: Independent Phase 1 review

- [ ] Fresh reviewer verifies GitHub, Cloudflare, and Supabase are isolated from unrelated projects.
- [ ] Verify both hosted Supabase projects are Frankfurt.
- [ ] Verify no paid resource was knowingly activated.
- [ ] Verify master credentials remain owner-controlled.
- [ ] Verify agent has not received Production credentials.
- [ ] Produce non-sensitive Phase 1 evidence report.

### Task 10: Phase 1 gate

- [ ] Proton ownership confirmed.
- [ ] Bitwarden owner vault ready.
- [ ] GitHub Organization owner-controlled.
- [ ] Cloudflare account owner-controlled.
- [ ] Supabase account/Organization owner-controlled.
- [ ] Separate Staging and Production projects exist in Frankfurt.
- [ ] No secret exposed.
- [ ] No paid upgrade.
- [ ] No repo/product code created.

Stop. Do not activate Phase 2 automatically.
