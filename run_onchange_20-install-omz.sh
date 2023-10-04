#!/bin/sh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "### Install Oh My Zsh ###"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    echo ""
fi

