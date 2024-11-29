# Usage

Aside from storing configuration files for a variety of applications, this repository provides scripts for debloating and setting up fresh Windows 10 installations (including WSL).

1.  From an Administrator Powershell terminal, install and enter WSL:

```powershell
$ wsl --install
```

2.  Then, in bash, run the setup script:

```powershell
$ curl -o- https://raw.githubusercontent.com/jejebecarte/dotfiles/refs/heads/master/windows/setup.sh | bash
```

# Limitations

This repository contains configuration files for a number of Windows applications. Symbolically linking these files to the WSL clone of this repository would necessitate that WSL be mounted unnecessarily for uses that don't require it. Therefore, the files for these apps are copied, and thus won't automatically update with the changes made in this repository.
