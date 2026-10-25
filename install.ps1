$dot = $PSScriptRoot
$bash = 'C:\msys64\usr\bin\bash.exe'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function Update-Path {
    $env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')
}

function Set-Stub($file, $content) {
    if ((Test-Path $file) -and (Get-Content $file -Raw) -eq "$content`n") { return }
    if ((Test-Path $file) -and -not ((Get-Content $file -Raw) -match [regex]::Escape((Split-Path $dot -Leaf)))) {
        Move-Item $file "$file.$(Get-Date -Format yyyyMMddHHmmss).bak"
    }
    New-Item -ItemType Directory -Force (Split-Path $file) | Out-Null
    [IO.File]::WriteAllText($file, "$content`n")
    Write-Host "linked $file"
}

function Set-Junction($link, $target) {
    $item = Get-Item $link -Force -ErrorAction SilentlyContinue
    if ($item -and $item.LinkType -and ($item.Target -replace '^\\\?\?\\', '') -contains $target) { return }
    if ($item -and $item.LinkType) { [IO.Directory]::Delete($link) }
    elseif ($item) { Move-Item $link "$link.$(Get-Date -Format yyyyMMddHHmmss).bak" }
    New-Item -ItemType Directory -Force (Split-Path $link) | Out-Null
    New-Item -ItemType Junction -Path $link -Target $target | Out-Null
    Write-Host "linked $link"
}

foreach ($id in Get-Content "$dot\windows\winget.txt") {
    if ($id -eq 'MSYS2.MSYS2' -and (Test-Path C:\msys64)) { continue }
    winget list --id $id -e --accept-source-agreements *> $null
    if ($LASTEXITCODE -ne 0) {
        winget install --id $id -e --silent --accept-source-agreements --accept-package-agreements
    }
}
Update-Path

$fontReg = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
$fonts = foreach ($key in $fontReg, 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts') {
    (Get-ItemProperty $key -ErrorAction SilentlyContinue).PSObject.Properties.Name
}
foreach ($style in 'Regular', 'Bold', 'Italic', 'Bold Italic') {
    $name = "MesloLGS NF $style"
    if ($fonts -like "$name (*") { continue }
    $file = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\$name.ttf"
    New-Item -ItemType Directory -Force (Split-Path $file) | Out-Null
    Invoke-WebRequest "https://github.com/romkatv/powerlevel10k-media/raw/master/$([uri]::EscapeDataString($name)).ttf" -OutFile $file -UseBasicParsing
    New-ItemProperty $fontReg -Name "$name (TrueType)" -Value $file -Force | Out-Null
    Write-Host "installed $name"
}

foreach ($ns in 'C:\msys64\etc\nsswitch.conf', 'C:\cygwin64\etc\nsswitch.conf') {
    if (-not (Test-Path $ns)) { continue }
    $lines = Get-Content $ns
    if ($lines -contains 'db_home: windows') { continue }
    $lines = @($lines | Where-Object { $_ -notmatch '^db_home:' }) + 'db_home: windows'
    [IO.File]::WriteAllText($ns, ($lines -join "`n") + "`n")
}

$env:MSYSTEM = 'MINGW64'
& $bash -lc 'pacman -Syu --noconfirm'
& $bash -lc 'pacman -Syu --noconfirm'
& $bash -lc "pacman -S --needed --noconfirm $((Get-Content "$dot\windows\pacman.txt") -join ' ')"

$dotUnix = '/' + $dot.Substring(0, 1).ToLower() + ($dot.Substring(2) -replace '\\', '/')
$dotMixed = $dot -replace '\\', '/'

Set-Stub "$env:APPDATA\alacritty\alacritty.toml" "[general]`nimport = [`"$dotMixed/common/.config/alacritty/theme.toml`", `"$dotMixed/windows/alacritty.toml`"]"
Set-Stub "$HOME\.bashrc" ". `"$dotUnix/windows/.bashrc`""
Set-Stub "$HOME\.tmux.conf" "source-file `"$dotUnix/common/.tmux.conf`""
Set-Stub "$HOME\.vimrc" "source $dotMixed/common/.vimrc"
Set-Junction "$env:LOCALAPPDATA\nvim" "$dot\common\.config\nvim"
Set-Junction "$HOME\.config\mise" "$dot\common\.config\mise"

$shims = "$env:LOCALAPPDATA\mise\shims"
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if (($userPath -split ';') -notcontains $shims) {
    [Environment]::SetEnvironmentVariable('Path', "$userPath;$shims", 'User')
}
Update-Path
mise install
