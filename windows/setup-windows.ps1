if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

Set-ExecutionPolicy RemoteSigned

# Install and configure apps for Powershell prompt customisation
Install-Module -Name PSReadLine -Force -SkipPublisherCheck -AllowClobber
Install-Module -Name Terminal-Icons
Update-Module

oh-my-posh font install CascadiaMono

# Install other apps not handled by winutil
winget install -e --id GnuPG.Gpg4win
winget install -e --id Proton.ProtonVPN 

# Link and copy files from WSL
New-Item -Path "$env:USERPROFILE\.gnupg\gpg-agent.conf" -ItemType SymbolicLink -Value "$PWD\gpg-agent.conf" -Force

# VSCode
New-Item -Path "$env:APPDATA\Code\User\settings.json" -ItemType SymbolicLink -Value "$PWD\vscode\settings.json" -Force

# PowerShell 5 & 7
Copy-Item "$PWD\windows\Microsoft.PowerShell_profile.ps1" -Destination "$env:USERPROFILE\Documents\WindowsPowerShell" -Force

# Windows Terminal
Move-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState.bak" -Force
Copy-Item "$PWD\terminal\settings.json" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"