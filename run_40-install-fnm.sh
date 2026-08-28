#!/usr/bin/env sh

echo ''
echo '### Install/update fnm ###'
echo ''

curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

"${HOME}/.local/share/fnm/fnm" install 24
