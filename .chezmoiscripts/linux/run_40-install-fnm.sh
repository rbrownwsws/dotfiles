#!/usr/bin/env sh

echo ''
echo '### Install/update fnm ###'
echo ''

curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

FNM_CMD="${HOME}/.local/share/fnm/fnm"

if command -v "${FNM_CMD}" >/dev/null 2>&1; then
  "${FNM_CMD}" install 24
fi
