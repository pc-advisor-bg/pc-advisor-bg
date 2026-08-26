$ErrorActionPreference = 'Stop'

$Repo = (git rev-parse --show-toplevel).Trim()
$SafetyScript = Join-Path $Repo 'scripts\verify-public-repo-safety.ps1'
$WindowsPowerShellExe = Join-Path $env:SystemRoot `
    'System32\WindowsPowerShell\v1.0\powershell.exe'

function Fail-Test {
    param([string]$Message)

    Write-Host "TEST FAIL: $Message"
    exit 1
}

function Invoke-Git {
    param(
        [string]$Repository,
        [string[]]$Arguments
    )

    $Output = @(git -C $Repository @Arguments)

    if ($LASTEXITCODE -ne 0) {
        $Output
        throw "git $($Arguments -join ' ') failed."
    }

    return $Output
}

function New-SafetyFixture {
    param([string]$Directory)

    New-Item -ItemType Directory -Path $Directory -Force | Out-Null
    Invoke-Git -Repository $Directory -Arguments @('init', '--initial-branch=main')

    Set-Content -LiteralPath (Join-Path $Directory '.gitignore') `
        -Value '.env*' -Encoding ASCII
    Set-Content -LiteralPath (Join-Path $Directory 'README.md') `
        -Value 'synthetic fixture' -Encoding ASCII

    Invoke-Git -Repository $Directory -Arguments @('add', '.gitignore', 'README.md')
    Invoke-Git -Repository $Directory -Arguments @(
        '-c', 'user.name=GitHub',
        '-c', 'user.email=noreply@github.com',
        'commit', '--author=Fixture <12345+fixture@users.noreply.github.com>',
        '-m', 'synthetic initial commit'
    )
    Invoke-Git -Repository $Directory -Arguments @('checkout', '-b', 'phase-2-fixture')
}

function Invoke-Safety {
    param([string]$Repository)

    Push-Location -LiteralPath $Repository

    try {
        $OriginalPreference = $ErrorActionPreference
        $ErrorActionPreference = 'Continue'

        $Output = @(
            & $WindowsPowerShellExe -NoProfile -ExecutionPolicy Bypass `
                -File $SafetyScript 2>&1
        )

        return @{
            ExitCode = $LASTEXITCODE
            Output = $Output
        }
    }
    finally {
        $ErrorActionPreference = $OriginalPreference
        Pop-Location
    }
}

function Assert-SafetyPass {
    param(
        [string]$Repository,
        [string]$Scenario,
        [switch]$PassThru
    )

    $Result = Invoke-Safety -Repository $Repository

    if ($Result.ExitCode -ne 0) {
        $Result.Output
        Fail-Test "$Scenario did not pass safety verification."
    }

    if ($PassThru) {
        return $Result
    }
}

function Assert-SafetyFail {
    param(
        [string]$Repository,
        [string]$Scenario,
        [switch]$PassThru
    )

    $Result = Invoke-Safety -Repository $Repository

    if ($Result.ExitCode -eq 0) {
        $Result.Output
        Fail-Test "$Scenario was not rejected by safety verification."
    }

    if ($PassThru) {
        return $Result
    }
}

function Assert-CleanWorkingTree {
    param(
        [string]$Repository,
        [string]$Scenario
    )

    $Status = @(Invoke-Git -Repository $Repository `
        -Arguments @('status', '--porcelain'))

    if ($Status.Count -ne 0) {
        $Status
        Fail-Test "$Scenario left Git changes behind."
    }
}

function Test-FailureCleanup {
    param([string]$Directory)

    $Probe = Join-Path $Directory '.cleanup-probe.key'
    $Runner = Join-Path $Directory 'failure-cleanup-runner.ps1'
    $EscapedDirectory = $Directory.Replace("'", "''")
    $EscapedSafety = $SafetyScript.Replace("'", "''")

    Set-Content -LiteralPath $Runner -Encoding ASCII -Value @"
`$ErrorActionPreference = 'Stop'
try {
    Set-Location -LiteralPath '$EscapedDirectory'
    Set-Content -LiteralPath '.cleanup-probe.key' -Value 'synthetic-only' -Encoding ASCII
    git add -f -- '.cleanup-probe.key'
    & '$EscapedSafety'
    if (`$LASTEXITCODE -eq 0) { throw 'safety failure was expected' }
    throw 'intentional test failure after safety probe'
}
finally {
    git reset -q -- '.cleanup-probe.key' 2>`$null
    Remove-Item -LiteralPath '.cleanup-probe.key' -Force -ErrorAction SilentlyContinue
}
"@

    try {
        $OriginalPreference = $ErrorActionPreference
        $ErrorActionPreference = 'Continue'
        $Output = @(
            & $WindowsPowerShellExe -NoProfile -ExecutionPolicy Bypass `
                -File $Runner 2>&1
        )
        $ExitCode = $LASTEXITCODE
    }
    finally {
        $ErrorActionPreference = $OriginalPreference
        Remove-Item -LiteralPath $Runner -Force -ErrorAction SilentlyContinue
    }

    if ($ExitCode -eq 0) {
        $Output
        Fail-Test 'cleanup probe did not preserve the intentional failure.'
    }

    if (Test-Path -LiteralPath $Probe) {
        Fail-Test 'cleanup probe file remained after failure.'
    }

    Assert-CleanWorkingTree -Repository $Directory `
        -Scenario 'failure cleanup probe'
    Assert-SafetyPass -Repository $Directory `
        -Scenario 'failure cleanup probe'
}

if (-not (Test-Path -LiteralPath $SafetyScript)) {
    Fail-Test 'safety implementation is missing.'
}

$FixtureRoot = Join-Path ([IO.Path]::GetTempPath()) `
    ("pc-advisor-bg-safety-tests-" + [guid]::NewGuid().ToString('N'))

try {
    New-SafetyFixture -Directory $FixtureRoot

    Write-Host '=== TEST: clean repository passes ==='
    Assert-SafetyPass -Repository $FixtureRoot -Scenario 'clean repository'
    Write-Host 'PASS clean repository'

    Write-Host "`n=== TEST: .env.local is ignored and absent from status ==="
    $EnvProbe = Join-Path $FixtureRoot '.env.local'
    Set-Content -LiteralPath $EnvProbe -Value 'SYNTHETIC_LOCAL_VALUE=fixture' `
        -Encoding ASCII

    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('check-ignore', '-q', '--', '.env.local')
    Assert-CleanWorkingTree -Repository $FixtureRoot -Scenario '.env.local probe'
    Remove-Item -LiteralPath $EnvProbe -Force
    Write-Host 'PASS .env.local ignored'

    Write-Host "`n=== TEST: forbidden tracked filename fails ==="
    $FilenameProbe = Join-Path $FixtureRoot '.safety-probe.key'
    Set-Content -LiteralPath $FilenameProbe -Value 'synthetic-only' `
        -Encoding ASCII
    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('add', '-f', '--', '.safety-probe.key')
    Invoke-Git -Repository $FixtureRoot -Arguments @(
        '-c', 'user.name=GitHub',
        '-c', 'user.email=noreply@github.com',
        'commit', '--author=Fixture <12345+fixture@users.noreply.github.com>',
        '-m', 'synthetic forbidden filename'
    )
    $FilenameResult = Assert-SafetyFail -Repository $FixtureRoot `
        -Scenario 'tracked forbidden filename' -PassThru

    if (($FilenameResult.Output -join "`n") -notmatch `
        'Tracked filename matches forbidden') {
        $FilenameResult.Output
        Fail-Test 'forbidden filename was not rejected by the filename rule.'
    }

    Invoke-Git -Repository $FixtureRoot -Arguments @('reset', '--hard', 'main')
    Write-Host 'PASS tracked forbidden filename rejected'

    Write-Host "`n=== TEST: forbidden tracked content fails ==="
    $ContentProbe = Join-Path $FixtureRoot 'content-probe.txt'
    Set-Content -LiteralPath $ContentProbe `
        -Value 'DEMO_API_KEY=synthetic-not-a-real-secret-123456789' `
        -Encoding ASCII
    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('add', '--', 'content-probe.txt')
    Invoke-Git -Repository $FixtureRoot -Arguments @(
        '-c', 'user.name=GitHub',
        '-c', 'user.email=noreply@github.com',
        'commit', '--author=Fixture <12345+fixture@users.noreply.github.com>',
        '-m', 'synthetic forbidden content'
    )
    $ContentResult = Assert-SafetyFail -Repository $FixtureRoot `
        -Scenario 'tracked forbidden content' -PassThru

    if (($ContentResult.Output -join "`n") -notmatch `
        'Tracked content matches forbidden') {
        $ContentResult.Output
        Fail-Test 'forbidden content was not rejected by the content rule.'
    }

    Invoke-Git -Repository $FixtureRoot -Arguments @('reset', '--hard', 'main')
    Write-Host 'PASS tracked forbidden content rejected'

    Write-Host "`n=== TEST: committed forbidden content cannot be hidden locally ==="
    $CommittedContentProbe = Join-Path $FixtureRoot `
        'committed-content-probe.txt'
    Set-Content -LiteralPath $CommittedContentProbe `
        -Value 'DEMO_API_KEY=synthetic-not-a-real-secret-123456789' `
        -Encoding ASCII
    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('add', '--', 'committed-content-probe.txt')
    Invoke-Git -Repository $FixtureRoot -Arguments @(
        '-c', 'user.name=GitHub',
        '-c', 'user.email=noreply@github.com',
        'commit', '--author=Fixture <12345+fixture@users.noreply.github.com>',
        '-m', 'synthetic committed forbidden content'
    )

    Set-Content -LiteralPath $CommittedContentProbe `
        -Value 'safe local replacement' -Encoding ASCII
    $SafeReplacementResult = Assert-SafetyFail -Repository $FixtureRoot `
        -Scenario 'committed forbidden content with safe local replacement' `
        -PassThru

    if (($SafeReplacementResult.Output -join "`n") -notmatch `
        'working tree is dirty') {
        $SafeReplacementResult.Output
        Fail-Test 'safe local replacement did not fail closed on dirty content.'
    }

    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('reset', '--hard', 'HEAD')
    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('rm', '--cached', '--', 'committed-content-probe.txt')
    $StagedDeletionResult = Assert-SafetyFail -Repository $FixtureRoot `
        -Scenario 'staged deletion of committed forbidden content' -PassThru

    if (($StagedDeletionResult.Output -join "`n") -notmatch `
        'index is dirty') {
        $StagedDeletionResult.Output
        Fail-Test 'staged deletion did not fail closed on dirty index state.'
    }

    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('reset', '--hard', 'HEAD')
    Remove-Item -LiteralPath $CommittedContentProbe -Force
    $UnstagedDeletionResult = Assert-SafetyFail -Repository $FixtureRoot `
        -Scenario 'unstaged deletion of committed forbidden content' -PassThru

    if (($UnstagedDeletionResult.Output -join "`n") -notmatch `
        'working tree is dirty') {
        $UnstagedDeletionResult.Output
        Fail-Test 'unstaged deletion did not fail closed on dirty content.'
    }

    Invoke-Git -Repository $FixtureRoot -Arguments @('reset', '--hard', 'main')
    Write-Host 'PASS committed forbidden content cannot be hidden locally'

    Write-Host "`n=== TEST: private author metadata fails ==="
    Set-Content -LiteralPath (Join-Path $FixtureRoot 'metadata-probe.txt') `
        -Value 'synthetic metadata probe' -Encoding ASCII
    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('add', '--', 'metadata-probe.txt')
    Invoke-Git -Repository $FixtureRoot -Arguments @(
        '-c', 'user.name=GitHub',
        '-c', 'user.email=noreply@github.com',
        'commit', '--author=Private Author <private.author@example.invalid>',
        '-m', 'synthetic private metadata'
    )
    $PrivateAuthorResult = Assert-SafetyFail -Repository $FixtureRoot `
        -Scenario 'private author metadata' -PassThru

    if (($PrivateAuthorResult.Output -join "`n") -notmatch `
        'non-approved author email') {
        $PrivateAuthorResult.Output
        Fail-Test 'private author metadata did not identify the author check.'
    }

    Invoke-Git -Repository $FixtureRoot -Arguments @('reset', '--hard', 'main')
    Write-Host 'PASS private author metadata rejected'

    Write-Host "`n=== TEST: private committer metadata fails ==="
    Set-Content -LiteralPath (Join-Path $FixtureRoot 'metadata-probe.txt') `
        -Value 'synthetic metadata probe' -Encoding ASCII
    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('add', '--', 'metadata-probe.txt')
    Invoke-Git -Repository $FixtureRoot -Arguments @(
        '-c', 'user.name=Private Committer',
        '-c', 'user.email=private.committer@example.invalid',
        'commit', '--author=Approved Author <12345+fixture@users.noreply.github.com>',
        '-m', 'synthetic private committer metadata'
    )
    $PrivateCommitterResult = Assert-SafetyFail -Repository $FixtureRoot `
        -Scenario 'private committer metadata' -PassThru

    if (($PrivateCommitterResult.Output -join "`n") -notmatch `
        'non-approved committer email') {
        $PrivateCommitterResult.Output
        Fail-Test 'private committer metadata did not identify the committer check.'
    }

    Invoke-Git -Repository $FixtureRoot -Arguments @('reset', '--hard', 'main')
    Write-Host 'PASS private committer metadata rejected'

    Write-Host "`n=== TEST: GitHub noreply metadata passes ==="
    Set-Content -LiteralPath (Join-Path $FixtureRoot 'noreply-probe.txt') `
        -Value 'synthetic noreply metadata probe' -Encoding ASCII
    Invoke-Git -Repository $FixtureRoot `
        -Arguments @('add', '--', 'noreply-probe.txt')
    Invoke-Git -Repository $FixtureRoot -Arguments @(
        '-c', 'user.name=GitHub',
        '-c', 'user.email=noreply@github.com',
        'commit', '--author=Noreply Fixture <67890+fixture@users.noreply.github.com>',
        '-m', 'synthetic safe metadata'
    )
    Assert-SafetyPass -Repository $FixtureRoot `
        -Scenario 'GitHub noreply metadata'
    Invoke-Git -Repository $FixtureRoot -Arguments @('reset', '--hard', 'main')
    Write-Host 'PASS GitHub noreply metadata allowed'

    Write-Host "`n=== TEST: cleanup restores clean PASS ==="
    Assert-CleanWorkingTree -Repository $FixtureRoot -Scenario 'probe cleanup'
    Assert-SafetyPass -Repository $FixtureRoot -Scenario 'probe cleanup'
    Write-Host 'PASS cleanup restores clean repository'

    Write-Host "`n=== TEST: probes are removed after failure ==="
    Test-FailureCleanup -Directory $FixtureRoot
    Write-Host 'PASS probes removed after failure'

    Write-Host 'SAFETY_TESTS=PASS'
}
finally {
    Remove-Item -LiteralPath $FixtureRoot -Recurse -Force `
        -ErrorAction SilentlyContinue
}
