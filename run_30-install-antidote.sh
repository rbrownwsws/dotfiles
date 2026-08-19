#!/usr/bin/env sh
set -eu

echo ""
echo "### Install/update antidote ###"
echo ""

ANTIDOTE_HOME="${ZDOTDIR:-"${HOME}"}/.antidote"

if [ ! -d "${ANTIDOTE_HOME}" ]; then
  GIT_TERMINAL_PROMPT=0 git clone --depth=1 https://github.com/mattmc3/antidote.git "${ANTIDOTE_HOME}"
fi

if command -v zsh >/dev/null 2>&1; then
  zsh -c "source \"${ANTIDOTE_HOME}/antidote.zsh\" && antidote update"
fi
