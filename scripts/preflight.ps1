$ErrorActionPreference = 'Continue'

$Failures = New-Object System.Collections.Generic.List[string]

function Add-Failure {
    param([string]$Message)

    $Failures.Add($Message)
    Write-Host "FAIL: $Message"
}

function Test-Executable {
    param(
        [string]$Name,
        [string]$Executable,
        [string[]]$Arguments
    )

    Write-Host "`n=== $Name ==="

    $CommandInfo = Get-Command -Name $Executable `
        -CommandType Application -ErrorAction SilentlyContinue |
        Select-Object -First 1

    if (-not $CommandInfo) {
        Add-Failure "$Name requires $Executable, but no executable was found."
        return
    }

    try {
        $global:LASTEXITCODE = 0
        & $CommandInfo.Source @Arguments
        $ExitCode = $LASTEXITCODE
    }
    catch {
        Add-Failure "$Name could not invoke $Executable."
        return
    }

    if ($ExitCode -ne 0) {
        Add-Failure "$Name failed with exit code $ExitCode."
    }
}

Write-Host '=== PC Advisor BG read-only preflight ==='

Test-Executable 'GIT VERSION' 'git' @('--version')
Test-Executable 'GIT PATHS' 'where.exe' @('git')

Write-Host "`n=== ACTIVE NODE ==="

$NodeCommand = Get-Command node -CommandType Application `
    -ErrorAction SilentlyContinue | Select-Object -First 1

if (-not $NodeCommand) {
    Add-Failure 'Node.js is required but the active node command was not found.'
}
else {
    $ActiveNodePath = $NodeCommand.Source
    $ActiveNodeVersion = (& $NodeCommand.Source --version 2>$null)

    if ($LASTEXITCODE -ne 0 -or -not $ActiveNodeVersion) {
        Add-Failure 'Node.js is required but node --version failed.'
    }
    else {
        $ActiveNodeVersion = $ActiveNodeVersion.Trim()

        Write-Host "ACTIVE_PATH=$ActiveNodePath"
        Write-Host "ACTIVE_VERSION=$ActiveNodeVersion"

        if (Test-Path -LiteralPath '.\.node-version') {
            $PinnedNode = (Get-Content '.\.node-version' -Raw).Trim()
            $ExpectedNodeVersion = "v$PinnedNode"

            Write-Host "PINNED_VERSION=$ExpectedNodeVersion"

            if ($ActiveNodeVersion -ne $ExpectedNodeVersion) {
                Add-Failure (
                    "Active Node version $ActiveNodeVersion does not match " +
                    "project pin $ExpectedNodeVersion."
                )
            }
        }
    }
}

Write-Host "`n=== ALL NODE PATHS ==="

$NodePaths = @(
    where.exe node 2>$null |
        ForEach-Object { $_.Trim() } |
        Where-Object { $_ }
)

if ($LASTEXITCODE -ne 0 -or $NodePaths.Count -eq 0) {
    Add-Failure 'Node.js is required but no node executable path was found.'
}
else {
    foreach ($NodePath in $NodePaths) {
        $Version = (& $NodePath --version 2>$null)

        if ($LASTEXITCODE -ne 0 -or -not $Version) {
            Add-Failure "Could not read Node version from $NodePath."
            continue
        }

        $Version = $Version.Trim()

        Write-Host $NodePath
        Write-Host "  version=$Version"

        if (
            $ActiveNodeVersion -and
            $Version -ne $ActiveNodeVersion
        ) {
            Write-Host (
                '  INFO: secondary Node executable differs from the ' +
                'active project runtime.'
            )
        }
    }
}

Write-Host "`n=== ACTIVE PNPM ==="

$PnpmCommand = Get-Command pnpm -CommandType Application `
    -ErrorAction SilentlyContinue | Select-Object -First 1

if (-not $PnpmCommand) {
    Add-Failure 'pnpm is required but the active pnpm command was not found.'
}
else {
    $ActivePnpmVersion = (& $PnpmCommand.Source --version 2>$null)

    if ($LASTEXITCODE -ne 0 -or -not $ActivePnpmVersion) {
        Add-Failure 'pnpm is required but pnpm --version failed.'
    }
    else {
        $ActivePnpmVersion = $ActivePnpmVersion.Trim()

        Write-Host "ACTIVE_PATH=$($PnpmCommand.Source)"
        Write-Host "ACTIVE_VERSION=$ActivePnpmVersion"

        if (Test-Path -LiteralPath '.\package.json') {
            try {
                $Package = Get-Content '.\package.json' -Raw |
                    ConvertFrom-Json

                $PackageManager = [string]$Package.packageManager

                if ($PackageManager -match '^pnpm@(.+)$') {
                    $PinnedPnpm = $Matches[1]

                    Write-Host "PINNED_VERSION=$PinnedPnpm"

                    if ($ActivePnpmVersion -ne $PinnedPnpm) {
                        Add-Failure (
                            "Active pnpm version $ActivePnpmVersion does not " +
                            "match project pin $PinnedPnpm."
                        )
                    }
                }
                else {
                    Add-Failure (
                        'package.json does not contain a valid pinned ' +
                        'pnpm packageManager value.'
                    )
                }
            }
            catch {
                Add-Failure 'package.json could not be parsed.'
            }
        }
    }
}

Test-Executable 'PNPM PATHS' 'where.exe' @('pnpm')

Write-Host "`n=== OPTIONAL VERSION MANAGERS ==="

if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm --version
}
else {
    Write-Host 'INFO: fnm not installed (optional).'
}

if (Get-Command nvm -ErrorAction SilentlyContinue) {
    nvm version
}
else {
    Write-Host 'INFO: nvm not installed (optional).'
}

if (Get-Command volta -ErrorAction SilentlyContinue) {
    volta --version
}
else {
    Write-Host 'INFO: Volta not installed (optional).'
}

Test-Executable 'DOCKER VERSION' 'docker' @('version')
Test-Executable 'DOCKER INFO' 'docker' @('info')

Write-Host "`n=== PREFLIGHT RESULT ==="

if ($Failures.Count -gt 0) {
    foreach ($Failure in $Failures) {
        Write-Host "- $Failure"
    }

    Write-Host 'PREFLIGHT=FAIL'
    exit 1
}

Write-Host 'PREFLIGHT=PASS'
exit 0
