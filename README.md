# Usage

Aside from storing configuration files for a variety of applications, this repository provides scripts for debloating and setting up fresh Windows 10 installations (including WSL).

See also: [Remove HP Bloatware](https://gist.github.com/mark05e/a79221b4245962a477a49eb281d97388).

1.  From an Administrator Powershell terminal, install and enter WSL:

```powershell
$ wsl --install
$ Set-ExecutionPolicy Unrestricted
```

2.  In bash, run the setup script:

```bash
$ curl -o- https://raw.githubusercontent.com/jejebecarte/dotfiles/refs/heads/master/windows/setup.sh | bash
```

3.  Import your GPG key pair:

```bash
$ gpg --import public.pgp
$ gpg --import private.pgp
```

4.  Back in Powershell, correct the machine's `ExecutionPolicy`:

```powershell
$ Set-ExecutionPolicy RemoteSigned
```

# Limitations

This repository contains configuration files for a number of Windows applications. Symbolically linking these files to the WSL clone of this repository would necessitate that WSL be mounted unnecessarily for uses that don't require it. Therefore, the files for these apps are copied, and thus won't automatically update with the changes made in this repository.
