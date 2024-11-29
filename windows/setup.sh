#!/bin/bash

mkdir ~/git
cd ~/git
git clone https://github.com/jejebecarte/dotfiles.git
cd dotfiles

# Create symlinks for dotfiles
files=(".bash_profile" ".bash_prompt" ".bashrc" ".gitattributes" ".gitconfig" ".gitignore" ".gitmessage" ".npmrc")
for file in ${files[@]}; do
    ln -sf "$PWD/$file" "$HOME/$file"
done

# Install and configure nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install lts
nvm use lts

# Install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Run Windows setup
powershell.exe -File ./windows/setup-windows.ps1