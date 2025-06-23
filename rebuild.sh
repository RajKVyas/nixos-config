#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

# Get the absolute path to the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Your hostname as defined in flake.nix nixosConfigurations."<hostname>"
# You confirmed your hostname is 'r-pc'
HOSTNAME="r-pc"

echo "Rebuilding NixOS configuration for host: $HOSTNAME"
echo "Flake location: $SCRIPT_DIR"
echo "---"

# Pass all arguments given to this script to nixos-rebuild
# This allows you to do ./rebuild.sh --upgrade or other flags
sudo nixos-rebuild switch --flake "path:$SCRIPT_DIR#$HOSTNAME" "$@"

echo "---"
echo "Rebuild complete."
