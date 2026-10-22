# Borderlands 2 - Arabic translation installer. Right-click this file > Run with PowerShell.
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Windows.Forms
function Get-Sha([string]$p) {
    $s = [System.IO.File]::OpenRead($p)
    try { return [System.BitConverter]::ToString([System.Security.Cryptography.SHA256]::Create().ComputeHash($s)).Replace("-", "") }
    finally { $s.Dispose() } }
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$m = Get-Content -Raw -Encoding UTF8 -Path (Join-Path $here "patch\manifest.json") | ConvertFrom-Json
$title = "Borderlands 2 - Arabic Translation"

function Show-Msg([string]$ar, [string]$en, [string]$icon = "Information") {
    if ($env:BL2AR_QUIET) { Write-Output "[$icon] $en"; return }   # scripted test runs
    $enL = ($en -split "`r`n" | ForEach-Object { [string][char]0x202A + $_ + [string][char]0x202C }) -join "`r`n"
    $opts = [System.Windows.Forms.MessageBoxOptions]::RtlReading -bor [System.Windows.Forms.MessageBoxOptions]::RightAlign
    [void][System.Windows.Forms.MessageBox]::Show("$ar`r`n`r`n$enL", $title, "OK", $icon, "Button1", $opts)
}
function Test-Game([string]$dir) { return ($dir -and (Test-Path (Join-Path $dir "Binaries\Win32\Borderlands2.exe"))) }
function Find-Game {
    $saved = Join-Path $here "game_folder.txt"
    $cands = @((Split-Path -Parent $here))
    if (Test-Path $saved) { $cands = @((Get-Content -Raw -Encoding UTF8 $saved).Trim()) + $cands }
    try {
        $steam = (Get-ItemProperty "HKCU:\Software\Valve\Steam" -ErrorAction Stop).SteamPath
        $vdf = Join-Path $steam "steamapps\libraryfolders.vdf"
        $libs = @($steam)
        if (Test-Path $vdf) {
            foreach ($x in [regex]::Matches((Get-Content -Raw $vdf), '"path"\s+"([^"]+)"')) { $libs += $x.Groups[1].Value -replace '\\\\', '\' }
        }
        foreach ($l in $libs) { $cands += (Join-Path $l "steamapps\common\Borderlands 2") }
    } catch {}
    foreach ($c in $cands) { if (Test-Game $c) { return (Resolve-Path $c).Path } }
    $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
    $dlg.Description = "اختر مجلد اللعبة Borderlands 2`r`nChoose the Borderlands 2 game folder"
    while ($dlg.ShowDialog() -eq "OK") {
        if (Test-Game $dlg.SelectedPath) { return $dlg.SelectedPath }
        Show-Msg "هذا المجلد ليس مجلد Borderlands 2." "This is not the Borderlands 2 folder." "Warning"
    }
    return $null
}
function Find-Entry([byte[]]$b, [string]$name) {
    $key = [System.Text.Encoding]::ASCII.GetBytes($name + [char]0)
    $hits = @()
    for ($i = 0; $i -le $b.Length - $key.Length; $i++) {
        if ($b[$i] -ne $key[0]) { continue }
        $ok = $true
        for ($j = 1; $j -lt $key.Length; $j++) { if ($b[$i + $j] -ne $key[$j]) { $ok = $false; break } }
        if ($ok) { $hits += ($i + $key.Length) }
    }
    return ,$hits
}
function Hex([byte[]]$b, [int]$at) { return [System.BitConverter]::ToString($b, $at, 20).Replace("-", "") }

if (Get-Process -Name Borderlands2 -ErrorAction SilentlyContinue) {
    Show-Msg "أغلق اللعبة أولًا ثم حاول مرة أخرى." "Close the game first, then try again." "Warning"; exit 1 }
$game = Find-Game
if (-not $game) { exit 1 }
# files of a DLC the player does not have are skipped (no DLC folder is created)
$m.files = @($m.files | Where-Object { $_.path -notmatch '^DLC\\([^\\]+)\\' -or (Test-Path (Join-Path $game ("DLC\" + $Matches[1] + "\Compat\Config"))) })
$exePath = Join-Path $game $m.exe
$exe = [System.IO.File]::ReadAllBytes($exePath)
$where = @{}
foreach ($e in $m.exe_entries) {
    $hits = Find-Entry $exe $e.name
    if ($hits.Count -ne 1) { Show-Msg "ملف اللعبة Borderlands2.exe غير مطابق لهذا التعريب." "Borderlands2.exe does not match this mod." "Error"; exit 1 }
    $now = Hex $exe $hits[0]
    if ($now -ne $e.stock -and $now -ne $e.patched) {
        Show-Msg "إصدار اللعبة غير مطابق (المطلوب: Steam Build $($m.steam_build))." "Your game version does not match (needed: Steam build $($m.steam_build))." "Error"; exit 1 }
    $where[$e.name] = $hits[0]
}
foreach ($f in $m.files) {
    $dst = Join-Path $game $f.path
    if ($f.stock_sha256 -and (Test-Path $dst)) {
        $h = Get-Sha $dst
        if ($h -ne $f.stock_sha256 -and $h -ne $f.patched_sha256) {
            Show-Msg "الملف $($f.path) لا يطابق نسخة اللعبة الأصلية. تحقق من ملفات اللعبة في Steam ثم ثبّت من جديد." "$($f.path) does not match the original game. Verify the game files in Steam, then install again." "Error"; exit 1 }
    }
}
$bak = Join-Path $game "BL2-Arabic-backup"
foreach ($f in $m.files) {
    $dst = Join-Path $game $f.path
    $b = Join-Path $bak $f.path
    if ((Test-Path $dst) -and -not (Test-Path $b) -and $f.stock_sha256 -and ((Get-Sha $dst) -eq $f.stock_sha256)) {
        New-Item -ItemType Directory -Force (Split-Path -Parent $b) | Out-Null
        Copy-Item $dst $b -Force
    }
}
$exeBak = Join-Path $bak $m.exe
if (-not (Test-Path $exeBak)) {
    New-Item -ItemType Directory -Force (Split-Path -Parent $exeBak) | Out-Null
    Copy-Item $exePath $exeBak -Force
}
foreach ($f in $m.files) {
    $dst = Join-Path $game $f.path
    New-Item -ItemType Directory -Force (Split-Path -Parent $dst) | Out-Null
    Copy-Item (Join-Path $here ("patch\files\" + $f.path)) $dst -Force
}
foreach ($e in $m.exe_entries) {
    $new = [byte[]]::new(20)
    for ($k = 0; $k -lt 20; $k++) { $new[$k] = [Convert]::ToByte($e.patched.Substring(2 * $k, 2), 16) }
    [Array]::Copy($new, 0, $exe, $where[$e.name], 20)
}
[System.IO.File]::WriteAllBytes($exePath, $exe)
foreach ($f in $m.files) {
    if ((Get-Sha (Join-Path $game $f.path)) -ne $f.patched_sha256) {
        Show-Msg "فشل التحقق من $($f.path). شغّل Uninstall.ps1." "Check failed for $($f.path). Run Uninstall.ps1." "Error"; exit 1 }
}
Set-Content -Encoding UTF8 -Path (Join-Path $here "game_folder.txt") -Value $game
Show-Msg "تم تثبيت التعريب. شغّل اللعبة واترك اللغة على الإنجليزية.`r`nملاحظة: إذا حدّثت Steam اللعبة، شغّل Install.ps1 مرة أخرى.`r`n$game" "The Arabic translation is installed. Start the game with the language set to English.`r`nIf Steam updates the game, run Install.ps1 again.`r`n$game"
