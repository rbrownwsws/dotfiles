#!/usr/bin/env sh

if [ "$(getent passwd "${USER}" | cut -d: -f7)" != "$(command -v zsh)" ]; then
    echo "### Changing login shell to zsh ###"

    chsh -s "$(command -v zsh)"

    echo ""
fi

