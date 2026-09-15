#!/usr/bin/env bash
# Renders export/*.png from index.html with headless Chrome.
# Override the browser path with CHROME=/path/to/chrome if needed.
set -euo pipefail
cd "$(dirname "$0")/.."
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
PROFILE="${TMPDIR:-/tmp}/nexa-energy-per-tx-chrome-profile"
# shot <figure 1|2> <light|dark> <height> <output>
shot() {
  timeout 90 "$CHROME" --headless=old --disable-gpu --no-first-run --no-default-browser-check \
    --user-data-dir="$PROFILE" --hide-scrollbars --force-device-scale-factor=2 \
    --window-size=1200,$3 --timeout=9000 --screenshot="$4" \
    "file://$PWD/index.html?export=$1&theme=$2" >/dev/null 2>&1
}
mkdir -p export
shot 1 light 890 export/nexa-vs-bitcoin-energy-per-tx.png
shot 1 dark  890 export/nexa-vs-bitcoin-energy-per-tx-dark.png
shot 2 light 915 export/nexa-vs-bitcoin-energy-per-tx-linear.png
shot 2 dark  915 export/nexa-vs-bitcoin-energy-per-tx-linear-dark.png
echo "Rendered four PNGs in export/"
