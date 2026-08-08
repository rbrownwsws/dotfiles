#!/usr/bin/env sh
set -eu

MISE_INSTALL_PATH="${HOME}/.local/bin/mise"
export MISE_INSTALL_PATH

MISE_INSTALLER_KEY_FPR="24853EC9F655CE80B48E6C3A8B81C9D17413A06D"

if [ -f "${MISE_INSTALL_PATH}" ]; then
  "${MISE_INSTALL_PATH}" self-update
else
  echo "mise not installed! Installing..."

  TMPDIR=$(mktemp -d)
  trap 'rm -rf "${TMPDIR}"' EXIT INT TERM

  # Create a new gpg keyring just for this install
  GNUPGHOME="${TMPDIR}/gnupg"
  mkdir -m 700 "${GNUPGHOME}"
  export GNUPGHOME

  echo ""
  echo "### Fetching installer key... ###"
  FETCH_KEY_STATUS="${TMPDIR}/fetch-key.gpg.log"
  gpg \
    --batch \
    --status-file "${FETCH_KEY_STATUS}" \
    --keyserver hkps://keys.openpgp.org \
    --recv-keys "${MISE_INSTALLER_KEY_FPR}"

  MISE_ENC_INSTALLER_SCRIPT="${TMPDIR}/install.sh.sig"
  MISE_INSTALLER_SCRIPT="${TMPDIR}/install.sh"

  echo ""
  echo "### Downloading installer... ###"
  curl -fL https://mise.jdx.dev/install.sh.sig -o "${MISE_ENC_INSTALLER_SCRIPT}"

  echo ""
  echo "### Decrypting installer... ###"
  DECRYPT_FILE_STATUS="${TMPDIR}/decrypt-file.gpg.log"
  gpg \
    --batch \
    --status-file "${DECRYPT_FILE_STATUS}" \
    --decrypt "${MISE_ENC_INSTALLER_SCRIPT}" \
    > "${MISE_INSTALLER_SCRIPT}"

  echo ""
  echo "### Check that correct signature was used... ###"
  if ! grep -q "VALIDSIG ${MISE_INSTALLER_KEY_FPR}" "${DECRYPT_FILE_STATUS}"; then
    echo "Signature did not come from the expected mise release key" >&2
    exit 1
  else
    echo "Signature OK!"
  fi

  echo ""
  echo "### Run mise installer... ###"
  chmod +x "${MISE_INSTALLER_SCRIPT}"
  "${MISE_INSTALLER_SCRIPT}"
fi
