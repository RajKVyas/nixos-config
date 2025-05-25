#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

echo "Changing to directory: $SCRIPT_DIR"
cd "$SCRIPT_DIR" || exit 1 # Change to the script's directory or exit if it fails

echo "---"
echo "Updating flake inputs (flake.lock)..."
nix flake update
echo "---"
echo "Flake inputs updated."
echo ""
read -p "Would you like to rebuild the system now? (y/N): " choice
case "$choice" in
  y|Y )
    echo "Proceeding with rebuild..."
    # Assuming rebuild.sh is in the same directory and executable
    "$SCRIPT_DIR/rebuild.sh"
    ;;
  * )
    echo "Rebuild skipped. Run ./rebuild.sh manually when ready."
    ;;
esac
