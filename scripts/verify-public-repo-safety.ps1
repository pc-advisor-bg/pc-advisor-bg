$ErrorActionPreference = 'Continue'

$Failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)

    $Failures.Add($Message)
    Write-Host "FAIL: $Message"
}

function Test-ApprovedGitHubNoreplyEmail {
    param([string]$Email)

    if ([string]::IsNullOrWhiteSpace($Email)) {
        return $false
    }

    return $Email -match `
        '^(?i:noreply@github\.com|(?:[0-9]+\+)?[^@\s]+@users\.noreply\.github\.com)$'
}

function Test-CleanGitState {
    param(
        [string]$Name,
        [string[]]$Arguments
    )

    git diff @Arguments *> $null

    switch ($LASTEXITCODE) {
        0 { return }
        1 {
            Add-Failure "$Name is dirty; safety verification requires HEAD-equivalent tracked content."
            return
        }
        default {
            Add-Failure "Could not verify $Name state."
            return
        }
    }
}

$Repo = (git rev-parse --show-toplevel 2>$null)

if ($LASTEXITCODE -ne 0 -or -not $Repo) {
    Write-Host 'FAIL: not inside a Git repository.'
    exit 1
}

$Repo = $Repo.Trim()
Set-Location -LiteralPath $Repo

Write-Host '=== PC Advisor BG public repository safety ==='

Test-CleanGitState 'working tree' @(
    '--quiet', '--ignore-submodules', '--'
)
Test-CleanGitState 'index' @(
    '--cached', '--quiet', '--ignore-submodules', '--'
)

$Tracked = @(
    git ls-files |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ }
)

if ($LASTEXITCODE -ne 0) {
    Write-Host 'FAIL: could not enumerate tracked files.'
    exit 1
}

$FilenameRules = @(
    @{
        Name = 'secret-bearing environment file'
        Pattern = '(?i)(^|/)\.env(?:$|\.)'
        Allow = '(?i)(^|/)\.env\.(?:example|sample|template)$'
    },
    @{
        Name = 'private key or certificate material'
        Pattern = '(?i)(^|/)(?:id_rsa|id_ed25519|id_ecdsa|id_dsa)(?:\..*)?$|\.(?:pem|key|p12|pfx|cer|crt|der|jks|keystore)$'
        Allow = $null
    },
    @{
        Name = 'database dump or backup artifact'
        Pattern = '(?i)(^|/)(?:dumps?|backups?)(?:/|$)|\.(?:dump|pgdump|backup|bak|sql\.gz)$'
        Allow = $null
    },
    @{
        Name = 'local Supabase runtime state'
        Pattern = '(?i)(^|/)\.supabase/|(^|/)supabase/(?:\.temp|\.branches)/'
        Allow = $null
    }
)

foreach ($Path in $Tracked) {
    $Normalized = $Path -replace '\\', '/'

    foreach ($Rule in $FilenameRules) {
        if ($Normalized -match $Rule.Pattern) {
            if ($Rule.Allow -and $Normalized -match $Rule.Allow) {
                continue
            }

            Add-Failure (
                "Tracked filename matches forbidden " +
                "$($Rule.Name): $Normalized"
            )
        }
    }
}

$SecretName =
    '(?:[A-Za-z0-9_]*(?:PASSWORD|PASSWD|SECRET|TOKEN|' +
    'API[_-]?KEY|SERVICE[_-]?ROLE[_-]?KEY|' +
    'PRIVATE[_-]?KEY)[A-Za-z0-9_]*)'

$SecretAssignment =
    '(?im)^\s*' + $SecretName +
    '\s*[:=]\s*["'']?[^\s#"''][^\r\n]{7,}'

$PrivateKeyHeader =
    '-----BEGIN ' +
    '(?:RSA |EC |OPENSSH |DSA )?' +
    'PRIVATE KEY-----'

$DatabaseCredentialUri =
    '(?i)\b(?:postgres(?:ql)?|mysql|mongodb(?:\+srv)?):' +
    '//[^:\s/]+:[^@\s/]+@'

$GitHubToken =
    '\bgh[pousr]_[A-Za-z0-9_]{20,}\b'

$ContentRules = @(
    @{
        Name = 'private key material'
        Pattern = $PrivateKeyHeader
    },
    @{
        Name = 'obvious secret assignment'
        Pattern = $SecretAssignment
    },
    @{
        Name = 'database URL containing credentials'
        Pattern = $DatabaseCredentialUri
    },
    @{
        Name = 'GitHub credential token'
        Pattern = $GitHubToken
    }
)

$BinaryExtensions = @(
    '.png', '.jpg', '.jpeg', '.gif', '.webp', '.ico',
    '.zip', '.gz', '.7z', '.pdf',
    '.woff', '.woff2', '.ttf', '.eot',
    '.exe', '.dll'
)

foreach ($Path in $Tracked) {
    $Extension = [IO.Path]::GetExtension($Path).ToLowerInvariant()

    if ($BinaryExtensions -contains $Extension) {
        continue
    }

    $FullPath = Join-Path $Repo ($Path -replace '/', '\')

    if (-not (Test-Path -LiteralPath $FullPath -PathType Leaf)) {
        Add-Failure "Could not inspect committed tracked file: $Path"
        continue
    }

    try {
        $Reader = New-Object System.IO.StreamReader(
            $FullPath,
            $true
        )

        try {
            $Content = $Reader.ReadToEnd()
        }
        finally {
            $Reader.Dispose()
        }
    }
    catch {
        Add-Failure "Could not safely inspect tracked file: $Path"
        continue
    }

    foreach ($Rule in $ContentRules) {
        if ($Content -match $Rule.Pattern) {
            Add-Failure (
                "Tracked content matches forbidden " +
                "$($Rule.Name): $Path"
            )
        }
    }
}

Write-Host "`n=== COMMIT METADATA ==="

$HistoryRange = $null

git rev-parse --verify --quiet 'origin/main' *> $null

if ($LASTEXITCODE -eq 0) {
    $HistoryRange = 'origin/main..HEAD'
}
else {
    git rev-parse --verify --quiet 'main' *> $null

    if ($LASTEXITCODE -eq 0) {
        $HistoryRange = 'main..HEAD'
    }
}

if ($HistoryRange) {
    $Metadata = @(
        git log --format='%H%x09%ae%x09%ce' $HistoryRange
    )

    if ($LASTEXITCODE -ne 0) {
        Add-Failure 'Could not inspect relevant commit metadata.'
        $Metadata = @()
    }
    elseif ($Metadata.Count -eq 0) {
        $Metadata = @(git log --format='%H%x09%ae%x09%ce' HEAD)

        if ($LASTEXITCODE -ne 0) {
            Add-Failure 'Could not inspect current commit metadata.'
            $Metadata = @()
        }
    }
}
else {
    $Metadata = @(git log --format='%H%x09%ae%x09%ce' HEAD)

    if ($LASTEXITCODE -ne 0) {
        Add-Failure 'Could not inspect current commit metadata.'
        $Metadata = @()
    }
}

foreach ($Entry in $Metadata) {
    $Fields = $Entry -split "`t", 3

    if ($Fields.Count -ne 3) {
        Add-Failure 'Could not parse commit metadata.'
        continue
    }

    $Commit = $Fields[0]
    $AuthorEmail = $Fields[1]
    $CommitterEmail = $Fields[2]

    if (-not (Test-ApprovedGitHubNoreplyEmail $AuthorEmail)) {
        Add-Failure "Commit $Commit has a non-approved author email."
    }

    if (-not (Test-ApprovedGitHubNoreplyEmail $CommitterEmail)) {
        Add-Failure "Commit $Commit has a non-approved committer email."
    }
}

Write-Host "`n=== SAFETY RESULT ==="

if ($Failures.Count -gt 0) {
    foreach ($Failure in $Failures) {
        Write-Host "- $Failure"
    }

    Write-Host 'PUBLIC_REPO_SAFETY=FAIL'
    exit 1
}

Write-Host 'PUBLIC_REPO_SAFETY=PASS'
exit 0
