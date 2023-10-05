#!/bin/sh

if [ "$(getent passwd $USER | cut -d: -f7)" != "$(which zsh)" ]; then
    echo "### Changing login shell to zsh ###"

    chsh -s $(which zsh)

    echo ""
fi

