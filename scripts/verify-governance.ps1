$ErrorActionPreference = 'Continue'

$Failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)

    $Failures.Add($Message)
    Write-Host "FAIL: $Message"
}

$Repo = (git rev-parse --show-toplevel 2>$null)

if ($LASTEXITCODE -ne 0 -or -not $Repo) {
    Write-Host 'FAIL: not inside a Git repository.'
    exit 1
}

$Repo = $Repo.Trim()
Set-Location -LiteralPath $Repo

Write-Host '=== PC Advisor BG governance verification ==='

$RequiredFiles = @(
    'AGENTS.md',
    'docs/governance/PROJECT_CHARTER.md',
    'docs/governance/AGENT_AUTONOMY.md',
    'docs/governance/STOP_CONDITIONS.md',
    'docs/governance/TOOL_POLICY.md',
    'docs/governance/REPORTING_STANDARD.md',
    'docs/owner/OWNER_GUIDE_BG.md',
    'docs/owner/GLOSSARY_BG.md',
    'docs/owner/DAY_ZERO_SETUP_BG.md',
    'docs/infrastructure/GITHUB.md',
    'docs/infrastructure/SUPABASE.md',
    'docs/infrastructure/CLOUDFLARE.md',
    'docs/infrastructure/SECRETS.md',
    'docs/infrastructure/BACKUP_AND_RESTORE.md',
    'docs/operations/ADMIN_OPERATIONS_BG.md',
    'docs/operations/STAGING.md',
    'docs/operations/PRODUCTION_RELEASE.md',
    'docs/operations/INCIDENT_RUNBOOK_BG.md',
    'docs/phases/PHASES.md',
    'docs/phases/briefs/.gitkeep',
    'docs/decisions/README.md',
    'docs/decisions/0001-cloudflare-hosting.md',
    'docs/decisions/0002-public-source-rights-reserved.md',
    'docs/decisions/0003-private-project-tracking.md',
    'docs/decisions/0004-production-isolation.md',
    'docs/decisions/0005-no-external-ai-in-v1.md',
    'docs/decisions/0006-affiliate-neutrality.md',
    'docs/decisions/0007-admin-business-data-boundary.md',
    'docs/decisions/0008-layered-backup-model.md',
    'docs/decisions/0009-one-v1-repository.md',
    'docs/decisions/0010-zero-euro-recurring-cost-target.md',
    'docs/decisions/0011-runtime-version-selection.md'
)

foreach ($Path in $RequiredFiles) {
    $FullPath = Join-Path $Repo ($Path -replace '/', '\')

    if (-not (Test-Path -LiteralPath $FullPath -PathType Leaf)) {
        Add-Failure "Required operating-system file is missing: $Path"
    }
}

$TrackedMarkdown = @(
    git ls-files -- '*.md' |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ }
)

if ($LASTEXITCODE -ne 0) {
    Add-Failure 'Could not enumerate tracked Markdown files.'
    $TrackedMarkdown = @()
}

$AuthoritativeMarkdown = @(
    $TrackedMarkdown | Where-Object {
        $_ -eq 'AGENTS.md' -or
        $_ -match '^docs/(?:governance|owner|infrastructure|operations|phases|decisions)/'
    }
)

$UnfinishedMarker = '(?im)\b(?:TODO|TBD|FIXME|XXX)\b|^\s*[-*]\s+\[\s\]'
$SecretName =
    '(?:[A-Za-z0-9_]*(?:PASSWORD|PASSWD|SECRET|TOKEN|' +
    'API[_-]?KEY|SERVICE[_-]?ROLE[_-]?KEY|' +
    'PRIVATE[_-]?KEY)[A-Za-z0-9_]*)'
$SecretAssignment =
    '(?im)^\s*' + $SecretName +
    '\s*[:=]\s*["'']?[^\s#"''][^\r\n]{7,}'

$ContentByPath = @{}

foreach ($Path in $TrackedMarkdown) {
    $FullPath = Join-Path $Repo ($Path -replace '/', '\')

    if (-not (Test-Path -LiteralPath $FullPath -PathType Leaf)) {
        Add-Failure "Could not inspect tracked Markdown file: $Path"
        continue
    }

    try {
        $ContentByPath[$Path] = [IO.File]::ReadAllText($FullPath)
    }
    catch {
        Add-Failure "Could not read tracked Markdown file: $Path"
    }
}

foreach ($Path in $AuthoritativeMarkdown) {
    if ($ContentByPath.ContainsKey($Path) -and
        $ContentByPath[$Path] -match $UnfinishedMarker) {
        Add-Failure "Unfinished marker found in authoritative document: $Path"
    }
}

foreach ($Path in $TrackedMarkdown) {
    if ($ContentByPath.ContainsKey($Path) -and
        $ContentByPath[$Path] -match $SecretAssignment) {
        Add-Failure "Obvious secret assignment found in tracked Markdown: $Path"
    }
}

$AgentsPath = Join-Path $Repo 'AGENTS.md'

if (Test-Path -LiteralPath $AgentsPath -PathType Leaf) {
    $AgentsContent = [IO.File]::ReadAllText($AgentsPath)
    $RequiredRoutes = @(
        'docs/governance/AGENT_AUTONOMY.md',
        'docs/governance/STOP_CONDITIONS.md',
        'docs/governance/TOOL_POLICY.md',
        'docs/governance/REPORTING_STANDARD.md'
    )

    foreach ($Route in $RequiredRoutes) {
        if ($AgentsContent -notmatch [regex]::Escape($Route)) {
            Add-Failure "AGENTS.md does not route to: $Route"
        }
    }
}

if ($Failures.Count -gt 0) {
    Write-Host "`nGOVERNANCE=FAIL ($($Failures.Count) finding(s))"
    exit 1
}

Write-Host "`nGOVERNANCE=PASS"
exit 0
