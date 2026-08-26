$ErrorActionPreference = 'Stop'

$Repo = (git rev-parse --show-toplevel).Trim()
$SafetyScript = Join-Path $Repo 'scripts\verify-public-repo-safety.ps1'

function Invoke-Safety {
    $Output = @(
        & powershell -NoProfile -ExecutionPolicy Bypass `
            -File $SafetyScript 2>&1
    )

    return @{
        ExitCode = $LASTEXITCODE
        Output = $Output
    }
}

function Fail-Test {
    param([string]$Message)

    Write-Host "TEST FAIL: $Message"
    exit 1
}

if (-not (Test-Path -LiteralPath $SafetyScript)) {
    Write-Host 'TEST FAIL: safety implementation is missing.'
    exit 1
}

$FilenameProbe = Join-Path $Repo '.safety-probe.key'
$ContentProbe = Join-Path $Repo 'tests\ops\safety-content-probe.txt'
$EnvProbe = Join-Path $Repo '.env.local'

try {
    Write-Host '=== TEST: clean repository passes ==='

    $Clean = Invoke-Safety

    if ($Clean.ExitCode -ne 0) {
        $Clean.Output
        Fail-Test 'clean repository did not pass safety verification.'
    }

    Write-Host 'PASS clean repository'

    Write-Host "`n=== TEST: .env.local is ignored ==="

    Set-Content -LiteralPath $EnvProbe `
        -Value 'DUMMY_LOCAL_VALUE=synthetic-only' `
        -Encoding ASCII

    git check-ignore -q -- '.env.local'

    if ($LASTEXITCODE -ne 0) {
        Fail-Test '.env.local is not ignored.'
    }

    $EnvStatus = @(git status --short -- '.env.local')

    if ($EnvStatus.Count -ne 0) {
        Fail-Test '.env.local appears in Git status.'
    }

    Write-Host 'PASS .env.local ignored'

    Write-Host "`n=== TEST: tracked private-key filename fails ==="

    Set-Content -LiteralPath $FilenameProbe `
        -Value 'synthetic-only' `
        -Encoding ASCII

    git add -f -- '.safety-probe.key'

    $FilenameResult = Invoke-Safety

    if ($FilenameResult.ExitCode -eq 0) {
        Fail-Test 'tracked .key filename was not rejected.'
    }

    Write-Host 'PASS tracked forbidden filename rejected'

    git reset -q -- '.safety-probe.key'
    Remove-Item -LiteralPath $FilenameProbe -Force

    Write-Host "`n=== TEST: obvious secret assignment fails ==="

    $SecretProbe = 'DEMO_' + 'API_KEY=' +
        'synthetic-secret-value-123456789'

    Set-Content -LiteralPath $ContentProbe `
        -Value $SecretProbe `
        -Encoding ASCII

    git add -- 'tests/ops/safety-content-probe.txt'

    $ContentResult = Invoke-Safety

    if ($ContentResult.ExitCode -eq 0) {
        Fail-Test 'tracked synthetic secret assignment was not rejected.'
    }

    Write-Host 'PASS tracked forbidden content rejected'

    git reset -q -- 'tests/ops/safety-content-probe.txt'
    Remove-Item -LiteralPath $ContentProbe -Force

    Write-Host "`n=== TEST: cleanup returns repository to PASS ==="

    $Final = Invoke-Safety

    if ($Final.ExitCode -ne 0) {
        $Final.Output
        Fail-Test 'repository did not return to PASS after probe cleanup.'
    }

    Write-Host 'PASS final clean repository'
    Write-Host 'SAFETY_TESTS=PASS'
}
finally {
    git reset -q -- '.safety-probe.key' 2>$null
    git reset -q -- 'tests/ops/safety-content-probe.txt' 2>$null

    Remove-Item -LiteralPath $FilenameProbe `
        -Force -ErrorAction SilentlyContinue

    Remove-Item -LiteralPath $ContentProbe `
        -Force -ErrorAction SilentlyContinue

    Remove-Item -LiteralPath $EnvProbe `
        -Force -ErrorAction SilentlyContinue
}
