#!/bin/bash

# Create symlinks for dotfiles
files=(".bash_profile" ".bash_prompt" ".bashrc" ".gitattributes" ".gitconfig" ".gitignore" ".gitmessage" ".npmrc")
for file in ${files[@]}; do
    ln -sf "$PWD/${file}" "$HOME/${file}"
done