if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

# Run winutil (also manages O&O ShutUp config)
Invoke-RestMethod "https://christitus.com/win" | Invoke-Expression

# Install and configure apps for Powershell prompt customisation
Install-Module -Name PSReadLine -Force -SkipPublisherCheck -AllowClobber
Install-Module -Name Terminal-Icons
Update-Module

oh-my-posh font install CascadiaMono

# Install other apps not handled by winutil
winget install -e --id Proton.ProtonVPN 

# VSCode
New-Item -Path "$env:APPDATA\Code\User\settings.json" -ItemType SymbolicLink -Value "$PWD\vscode\settings.json" -Force
Select-String '(?:itemName=)([^"]*)' -Path vscode/extensions.md | Foreach { code --install-extension $_.matches.Groups[1].Value}

# PowerShell 5 & 7
Copy-Item "$PWD\windows\Microsoft.PowerShell_profile.ps1" -Destination "$env:USERPROFILE\Documents\WindowsPowerShell" -Force

# Windows Terminal
Move-Item "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState.bak" -Force
Copy-Item "$PWD\terminal\settings.json" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"