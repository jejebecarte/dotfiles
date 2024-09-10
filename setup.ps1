#Requires -RunAsAdministrator

Install-Module -Name PSReadLine -Force -SkipPublisherCheck -AllowClobber
Install-Module -Name Terminal-Icons
Update-Module

# Install scoop and other apps
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop update *
scoop bucket add extras
scoop install 7zip audacity bitwarden brave discord gpg4win git gnupg libreoffice nvm oh-my-posh spotify vscode windows-terminal

# Basic configuration of new apps
nvm install lts
nvm use lts
oh-my-posh font install CascadiaMono

# Debloat the machine
Invoke-Expression -Command $PSScriptRoot\windows\settings\debloat.ps1

# Create symlinks for dotfiles
$HomePaths = (".gitattributes", ".gitconfig", ".gitignore", ".gitmessage", ".npmrc")
foreach ($Path in $HomePaths) {
    New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\$Path" -Target "$PWD\$Path" -Force
}

# PowerShell 5 & 7
New-Item "$env:HOMEPATH\Documents\WindowsPowerShell" -ItemType SymbolicLink -Target "$PWD\windows\Microsoft.PowerShell_profile.ps1" -Force
# New-Item "$env:HOMEPATH\Documents\PowerShell" -ItemType SymbolicLink -Target "$PWD\windows\Microsoft.PowerShell_profile.ps1" -Force

# VSCode
New-Item "$env:APPDATA\Code\User\settings.json" -ItemType SymbolicLink -Target "$PWD\vscode\settings.json"

# Windows Terminal
Move-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState.bak" -Force
New-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -ItemType SymbolicLink -Target "$PWD\terminal" -Force
