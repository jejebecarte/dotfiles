#Requires -RunAsAdministrator

Install-Module -Name PSReadLine -Force -SkipPublisherCheck -AllowClobber
Install-Module -Name Terminal-Icons
Update-Module

# Install scoop and other not handled by winutil apps
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop update *
scoop bucket add extras
scoop bucket add nonportable
scoop install git gpg4win gnupg protonvpn-np

# Basic configuration of new apps
nvm install lts
nvm use lts
oh-my-posh font install CascadiaMono

cd $env:HOMEPATH
git clone https://github.com/jejebecarte/dotfiles.git
cd dotfiles

# Create symlinks for dotfiles
$HomePaths = (".gitattributes", ".gitconfig", ".gitconfig-windows", ".gitignore", ".gitmessage", ".npmrc")
foreach ($Path in $HomePaths) {
    New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\$Path" -Target "$PWD\$Path" -Force
}

New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gnupg\gpg-agent.conf" -Target "$PWD\gpg-agent.conf" -Force

# PowerShell 5 & 7
New-Item "$env:HOMEPATH\Documents\WindowsPowerShell" -ItemType SymbolicLink -Target "$PWD\windows\Microsoft.PowerShell_profile.ps1" -Force
# New-Item "$env:HOMEPATH\Documents\PowerShell" -ItemType SymbolicLink -Target "$PWD\windows\Microsoft.PowerShell_profile.ps1" -Force

# VSCode
New-Item "$env:APPDATA\Code\User\settings.json" -ItemType SymbolicLink -Target "$PWD\vscode\settings.json" -Force

# Windows Terminal
Move-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState.bak" -Force
New-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -ItemType SymbolicLink -Target "$PWD\terminal" -Force

# Install and up WSL
wsl --install
wsl -e ./windows/wsl-setup.sh