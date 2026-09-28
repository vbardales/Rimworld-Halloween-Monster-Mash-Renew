<#
.SYNOPSIS
  Checks that every step of this suite exists in the two step catalogues, without starting the game.

.DESCRIPTION
  An undefined step costs a whole Pickle run: the run is queued behind the others, the game starts, and
  the scenario dies on its first unknown sentence. This script reads the features and matches every
  step line against the vocabulary of Pickle itself and of PickleTools, which is all the suite uses
  (it has no C# steps of its own).

  WHAT IT IS NOT. It is not Pickle's own parser. It turns each catalogue row into a regular expression
  ({string} -> a quoted value, {int} and {float} -> numbers, {word} -> a bare word), so it can miss a
  step that Pickle would refuse for a reason of its own, and it cannot see a def or a stat that does not
  exist. It also checks the catalogue it is given, not the Pickle that will be staged: Pickle's steps.md
  is read from GitHub main (fetch it as below), and nothing here establishes that the Workshop build
  staged in the WSL is that version.

  Scenario Outlines are expanded by substitution: a <placeholder> inside quotes keeps its quotes, and one
  outside quotes (a count) becomes 1. A placeholder that no Examples column defines is reported.

.PARAMETER PickleCatalogue
  Path to a saved copy of Pickle's Docs/steps.md:
    gh api repos/RimWorks/Rimworld-Pickle/contents/Docs/steps.md --jq .content | base64 -d > pickle-steps.md

.PARAMETER ToolsCatalogue
  PickleTools' docs/steps.md (lower-case docs). The default is the sibling checkout.

.EXAMPLE
  powershell -File Tests/Pickle/Check-Steps.ps1 -PickleCatalogue $env:TEMP\pickle-steps.md
#>
param(
    [Parameter(Mandatory = $true)][string]$PickleCatalogue,
    [string]$ToolsCatalogue,
    [string]$Features
)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $ToolsCatalogue) { $ToolsCatalogue = Join-Path $here '..\..\..\PickleTools\docs\steps.md' }
if (-not $Features)       { $Features       = Join-Path $here 'Mod\Pickle\Features' }

function ConvertTo-Regex([string]$expression) {
    $e = $expression -replace '\\\(', '(' -replace '\\\)', ')' -replace '\\\{', '{' -replace '\\\}', '}'
    $out = New-Object System.Text.StringBuilder
    $i = 0
    while ($i -lt $e.Length) {
        if ($e[$i] -eq '{') {
            $j = $e.IndexOf('}', $i)
            $name = $e.Substring($i + 1, $j - $i - 1)
            switch ($name) {
                'string' { [void]$out.Append('"[^"]*"') }
                'int'    { [void]$out.Append('-?\d+') }
                'float'  { [void]$out.Append('-?\d+(?:\.\d+)?') }
                'word'   { [void]$out.Append('\S+') }
                default  { [void]$out.Append('.+?') }
            }
            $i = $j + 1
        } else {
            [void]$out.Append([regex]::Escape([string]$e[$i]))
            $i++
        }
    }
    '^' + $out.ToString() + '$'
}

function Read-Catalogue([string]$path) {
    if (-not (Test-Path $path)) { throw "Catalogue not found: $path" }
    foreach ($line in Get-Content $path -Encoding UTF8) {
        if ($line -match '^\|\s*`([^`]+)`') { $Matches[1] }
    }
}

$patterns = @()
foreach ($p in @($PickleCatalogue, $ToolsCatalogue)) {
    $rows = @(Read-Catalogue $p)
    if ($rows.Count -eq 0) { throw "No step rows read from $p" }
    Write-Output ("{0,4} step patterns read from {1}" -f $rows.Count, $p)
    $patterns += $rows | ForEach-Object { ConvertTo-Regex $_ }
}

$bad = 0; $steps = 0; $files = 0
foreach ($file in Get-ChildItem $Features -Filter *.feature | Sort-Object Name) {
    $files++
    $lines = Get-Content $file.FullName -Encoding UTF8
    $inOutline = $false; $columns = @()
    for ($n = 0; $n -lt $lines.Count; $n++) {
        $t = $lines[$n].Trim()
        if ($t -match '^Scenario Outline:') { $inOutline = $true }
        elseif ($t -match '^Scenario:')     { $inOutline = $false }
        if ($t -match '^Examples:') {
            $header = $lines[$n + 1].Trim().Trim('|').Split('|') | ForEach-Object { $_.Trim() }
            $columns = $header
        }
        if ($t -match '^(Given|When|Then|And|But)\s+(.+)$') {
            $steps++
            $text = $Matches[2]
            # placeholders outside quotes are counts: replace them; inside quotes they are already quoted text
            $text = [regex]::Replace($text, '"[^"]*"|<[^>]+>', { param($m) if ($m.Value.StartsWith('"')) { $m.Value } else { '1' } })
            $ok = $false
            foreach ($rx in $patterns) { if ($text -match $rx) { $ok = $true; break } }
            if (-not $ok) { $bad++; Write-Output ("UNDEFINED  {0}:{1}  {2}" -f $file.Name, ($n + 1), $t) }
        }
    }
    # placeholders against the columns of the file's Examples table
    $text = ($lines | Where-Object { $_ -notmatch '^\s*#' }) -join "`n"
    $exIdx = $text.IndexOf('Examples:')
    if ($exIdx -ge 0) {
        $head = ($text.Substring($exIdx) -split "`n")[1].Trim().Trim('|').Split('|') | ForEach-Object { $_.Trim() }
        $used = [regex]::Matches($text.Substring(0, $exIdx), '<([^>]+)>') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
        foreach ($u in $used) {
            if ($head -notcontains $u) { $bad++; Write-Output ("PLACEHOLDER {0}: <{1}> has no Examples column" -f $file.Name, $u) }
        }
    }
}
Write-Output ("{0} features, {1} step lines, {2} problem(s)" -f $files, $steps, $bad)
if ($bad -gt 0) { exit 1 }
