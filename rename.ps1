# Rename challenges and walkthrough directories/files
# Final mapping: 01->01, 04->02, 06->03, 02->04, 03->05, 05->06
# Uses temporary names (02a, 03a, 05a) to avoid collisions

$challengesDir = Join-Path $PSScriptRoot "SovCloud\challenges"
$walkthroughDir = Join-Path $PSScriptRoot "SovCloud\walkthrough"

function Rename-Challenge {
    param(
        [string]$From,
        [string]$To
    )

    # Rename challenge MD file
    $challengeFile = Join-Path $challengesDir "challenge-$From.md"
    if (Test-Path $challengeFile) {
        Rename-Item $challengeFile "challenge-$To.md"
        Write-Host "  challenge-$From.md -> challenge-$To.md"
    }

    # Rename solution MD file inside walkthrough directory, then rename the directory
    $walkthroughSubDir = Join-Path $walkthroughDir "challenge-$From"
    if (Test-Path $walkthroughSubDir) {
        $solutionFile = Join-Path $walkthroughSubDir "solution-$From.md"
        if (Test-Path $solutionFile) {
            Rename-Item $solutionFile "solution-$To.md"
            Write-Host "  solution-$From.md -> solution-$To.md"
        }

        Rename-Item $walkthroughSubDir "challenge-$To"
        Write-Host "  walkthrough/challenge-$From/ -> walkthrough/challenge-$To/"
    }
}

Write-Host "=== Phase 1: Rename to temporary names to avoid collisions ==="
Rename-Challenge "04" "02a"
Rename-Challenge "06" "03a"
Rename-Challenge "02" "04"
Rename-Challenge "03" "05a"
Rename-Challenge "05" "06"

Write-Host ""
Write-Host "=== Phase 2: Rename temporary names to final names ==="
Rename-Challenge "02a" "02"
Rename-Challenge "03a" "03"
Rename-Challenge "05a" "05"

Write-Host ""
Write-Host "Done! Final mapping: 01->01, 04->02, 06->03, 02->04, 03->05, 05->06"