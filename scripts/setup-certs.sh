#!/usr/bin/env bash
# Generate cert untuk *.shineeducationbali.test (trusted di browser).
# Di Windows/Git Bash: mkcert tidak perlu di-install global; script ini unduh binary ke .certs/
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CERTS_DIR="$REPO_ROOT/.certs"
MKCERT_URL="https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-windows-amd64.exe"

cd "$REPO_ROOT"
mkdir -p "$CERTS_DIR"

# Pakai mkcert dari PATH kalau ada, else pakai .certs/mkcert.exe (Windows)
if command -v mkcert >/dev/null 2>&1; then
  MKCERT="mkcert"
elif [ -x "$CERTS_DIR/mkcert.exe" ]; then
  MKCERT="$CERTS_DIR/mkcert.exe"
else
  echo "mkcert tidak ditemukan. Mengunduh ke .certs/mkcert.exe ..."
  if command -v curl >/dev/null 2>&1; then
    curl -sSL -o "$CERTS_DIR/mkcert.exe" "$MKCERT_URL"
  else
    echo "Butuh curl. Pasang curl atau unduh manual: $MKCERT_URL"
    exit 1
  fi
  chmod +x "$CERTS_DIR/mkcert.exe"
  MKCERT="$CERTS_DIR/mkcert.exe"
fi

"$MKCERT" -install
"$MKCERT" -cert-file "$CERTS_DIR/cert.pem" -key-file "$CERTS_DIR/key.pem" "*.shineeducationbali.test" "shineeducationbali.test"
echo "Sertifikat berhasil dibuat di .certs/"
