# Borderlands 2 - Arabic translation: restore the original game files.
$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Windows.Forms
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
if (Get-Process -Name Borderlands2 -ErrorAction SilentlyContinue) {
    Show-Msg "أغلق اللعبة أولًا ثم حاول مرة أخرى." "Close the game first, then try again." "Warning"; exit 1 }
$game = $null
$saved = Join-Path $here "game_folder.txt"
if (Test-Path $saved) { $game = (Get-Content -Raw -Encoding UTF8 $saved).Trim() }
if (-not (Test-Game $game)) { $game = Split-Path -Parent $here }
if (-not (Test-Game $game)) {
    $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
    $dlg.Description = "اختر مجلد اللعبة Borderlands 2`r`nChoose the Borderlands 2 game folder"
    if ($dlg.ShowDialog() -ne "OK" -or -not (Test-Game $dlg.SelectedPath)) { exit 1 }
    $game = $dlg.SelectedPath
}
$bak = Join-Path $game "BL2-Arabic-backup"
if (-not (Test-Path (Join-Path $bak $m.exe))) {
    Show-Msg "لم يتم العثور على النسخة الاحتياطية. لإزالة التعريب استخدم في Steam: خصائص اللعبة، ثم الملفات المثبتة، ثم التحقق من سلامة ملفات اللعبة." "No backup found. To remove the translation, use Steam: Properties, Installed Files, Verify integrity of game files." "Warning"; exit 1 }
foreach ($f in $m.files) {
    $dst = Join-Path $game $f.path
    $b = Join-Path $bak $f.path
    if (Test-Path $b) { Copy-Item $b $dst -Force }
    elseif (-not $f.stock_sha256 -and (Test-Path $dst)) { Remove-Item -Force $dst }
}
Copy-Item (Join-Path $bak $m.exe) (Join-Path $game $m.exe) -Force
Remove-Item -Recurse -Force $bak
Show-Msg "تمت إزالة التعريب وعادت ملفات اللعبة الأصلية." "The Arabic translation was removed and the original game files are back."
