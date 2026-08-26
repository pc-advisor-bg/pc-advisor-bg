$ErrorActionPreference = 'Stop'

$Repo = (git rev-parse --show-toplevel).Trim()
$PreflightScript = Join-Path $Repo 'scripts\preflight.ps1'

function Fail-Test {
    param([string]$Message)

    Write-Host "TEST FAIL: $Message"
    exit 1
}

function New-CommandShim {
    param(
        [string]$Directory,
        [string[]]$Commands
    )

    foreach ($Command in $Commands) {
        $Output = switch ($Command) {
            'git' { 'git version synthetic' }
            'node' { 'v24.19.0' }
            'pnpm' { '11.24.0' }
            default { "synthetic $Command" }
        }

        Set-Content -LiteralPath (Join-Path $Directory "$Command.cmd") `
            -Value "@echo off`r`necho $Output`r`nexit /b 0`r`n" `
            -Encoding ASCII
    }
}

function Invoke-PreflightWithPath {
    param([string]$PathValue)

    $PowerShellExe = Join-Path $env:SystemRoot `
        'System32\WindowsPowerShell\v1.0\powershell.exe'
    $Runner = Join-Path ([IO.Path]::GetTempPath()) `
        ("pc-advisor-bg-preflight-runner-" +
        [guid]::NewGuid().ToString('N') + '.ps1')

    $EscapedPath = $PathValue.Replace("'", "''")
    $EscapedScript = $PreflightScript.Replace("'", "''")

    Set-Content -LiteralPath $Runner -Encoding ASCII -Value @"
`$env:PATH = '$EscapedPath'
& '$EscapedScript'
exit `$LASTEXITCODE
"@

    $OriginalPreference = $ErrorActionPreference

    try {
        $ErrorActionPreference = 'Continue'

        $Output = @(
            & $PowerShellExe -NoProfile -ExecutionPolicy Bypass `
                -File $Runner 2>&1
        )

        return @{
            ExitCode = $LASTEXITCODE
            Output = $Output
        }
    }
    finally {
        $ErrorActionPreference = $OriginalPreference

        Remove-Item -LiteralPath $Runner -Force `
            -ErrorAction SilentlyContinue
    }
}

if (-not (Test-Path -LiteralPath $PreflightScript)) {
    Fail-Test 'preflight implementation is missing.'
}

$ShimRoot = Join-Path ([IO.Path]::GetTempPath()) `
    ("pc-advisor-bg-preflight-tests-" + [guid]::NewGuid().ToString('N'))

try {
    New-Item -ItemType Directory -Path $ShimRoot -Force | Out-Null

    $RequiredCommands = @('git', 'node', 'pnpm', 'docker')

    foreach ($MissingCommand in $RequiredCommands) {
        Get-ChildItem -LiteralPath $ShimRoot -Force | Remove-Item -Force

        $AvailableCommands = @($RequiredCommands | Where-Object {
            $_ -ne $MissingCommand
        })

        New-CommandShim -Directory $ShimRoot -Commands $AvailableCommands

        $FixturePath = $ShimRoot + ';' +
            (Join-Path $env:SystemRoot 'System32')

        $Result = Invoke-PreflightWithPath -PathValue $FixturePath

        if ($Result.ExitCode -eq 0) {
            $Result.Output
            Fail-Test "missing required $MissingCommand command returned exit code 0."
        }

        Write-Host "PASS missing required $MissingCommand command fails"
    }

    Write-Host 'PREFLIGHT_TESTS=PASS'
}
finally {
    Remove-Item -LiteralPath $ShimRoot -Recurse -Force `
        -ErrorAction SilentlyContinue
}
