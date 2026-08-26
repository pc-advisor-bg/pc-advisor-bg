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

Write-Host '=== PC Advisor BG public repository safety ==='

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
