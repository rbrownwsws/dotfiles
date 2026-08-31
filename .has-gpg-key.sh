#!/usr/bin/env sh

KEY_FINGERPRINT="${1}"

if ! command -v gpg >/dev/null 2>&1; then
    echo "false"
fi

if ! command -v awk >/dev/null 2>&1; then
    echo "false"
fi

gpg --list-secret-keys --with-colons | awk -v key_fingerprint="${KEY_FINGERPRINT}" 'BEGIN { FS = ":" ; FOUND = "false" } ; $1=="ssb" && $5==key_fingerprint { FOUND = "true"} ; END { print FOUND }'
