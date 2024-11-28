# Usage

Aside from storing configuration files for a variety of applications, this repository provides a script for debloating and setting up fresh Windows 10 installations.

To do so, run Powershell as Administrator and execute the following command:

```powershell
Invoke-RestMethod "https://github.com/jejebecarte/dotfiles/blob/master/windows/setup.ps1" | Invoke-Expression
```
