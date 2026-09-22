#!/usr/bin/env sh
set -eu

echo ""
echo "### Install/update zsh plugins using antidote ###"
echo ""

ANTIDOTE_HOME="${ZDOTDIR:-"${HOME}"}/.antidote"

if command -v zsh >/dev/null 2>&1; then
  zsh -c "source \"${ANTIDOTE_HOME}/antidote.zsh\" && antidote update --bundles"
fi
