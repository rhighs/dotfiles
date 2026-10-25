# windows bootstrap: winget apps + font, msys2 update, then install.sh inside msys2
# run: powershell -ExecutionPolicy Bypass -File install.ps1
$root = $PSScriptRoot
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

foreach ($line in Get-Content "$root\win32\winget.txt") {
    $id = ($line -split '#')[0].Trim()
    if (-not $id) { continue }
    if ($id -eq 'MSYS2.MSYS2' -and (Test-Path C:\msys64)) { Write-Host "ok $id"; continue }
    winget list --id $id -e --accept-source-agreements *> $null
    if ($LASTEXITCODE -eq 0) { Write-Host "ok $id"; continue }
    winget install --id $id -e --silent --accept-source-agreements --accept-package-agreements
}

# MesloLGS NF (menlo-based, used by win32/alacritty), per-user install
$fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
$fontReg = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
$have = @()
foreach ($key in $fontReg, 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts') {
    $props = Get-ItemProperty $key -ErrorAction SilentlyContinue
    if ($props) { $have += $props.PSObject.Properties.Name }
}
foreach ($style in 'Regular', 'Bold', 'Italic', 'Bold Italic') {
    $name = "MesloLGS NF $style"
    if ($have | Where-Object { $_ -like "$name (*" }) { continue }
    New-Item -ItemType Directory -Force $fontDir | Out-Null
    $file = "$fontDir\$name.ttf"
    Invoke-WebRequest "https://github.com/romkatv/powerlevel10k-media/raw/master/$([uri]::EscapeDataString($name)).ttf" -OutFile $file -UseBasicParsing
    New-ItemProperty $fontReg -Name "$name (TrueType)" -Value $file -Force | Out-Null
    Write-Host "installed font $name"
}

$bash = 'C:\msys64\usr\bin\bash.exe'
$env:MSYSTEM = 'MINGW64'
$env:CHERE_INVOKING = '1'
# core packages update first and can need a second pass
& $bash -lc 'pacman -Syu --noconfirm'
& $bash -lc 'pacman -Syu --noconfirm'
Push-Location $root
& $bash --login ./install.sh
Pop-Location
