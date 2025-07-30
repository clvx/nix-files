#!/usr/bin/env bash
set -euo pipefail   # exit on any error including the installer

echo "1. Installing Nix package manager"
echo "Nix installation from Determinate Systems: https://zero-to-nix.com/start/install/"

curl --proto '=https' --tlsv1.2 -sSf -L \
     https://install.determinate.systems/nix \
  | sh -s -- install --no-confirm

echo "2. Loading Nix into the current shell"
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

if ! command -v nix >/dev/null; then
  echo "FATAL: nix is still not in PATH" >&2
  exit 1
fi
echo "Nix $(nix --version) is ready."

echo "3. Setting up Nix configuration..."
# --impure lets the flake read $USER/$HOME
nix run --impure .
