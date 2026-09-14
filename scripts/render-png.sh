#!/usr/bin/env bash
# Renders export/*.png from index.html with headless Chrome.
# Override the browser path with CHROME=/path/to/chrome if needed.
set -euo pipefail
cd "$(dirname "$0")/.."
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
PROFILE="$(mktemp -d)"
shot() {
  "$CHROME" --headless=old --disable-gpu --no-first-run --no-default-browser-check \
    --user-data-dir="$PROFILE" --hide-scrollbars --force-device-scale-factor=2 \
    --window-size=1200,890 --timeout=9000 --screenshot="$2" \
    "file://$PWD/index.html?export=1&theme=$1" >/dev/null 2>&1
}
mkdir -p export
shot light export/nexa-vs-bitcoin-energy-per-tx.png
shot dark  export/nexa-vs-bitcoin-energy-per-tx-dark.png
rm -rf "$PROFILE"
echo "Rendered export/nexa-vs-bitcoin-energy-per-tx.png and export/nexa-vs-bitcoin-energy-per-tx-dark.png"
