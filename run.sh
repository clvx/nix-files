#!/usr/bin/env bash

echo "1. Installing Nix package manager..."
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
  | sh -s -- install --no-confirm

echo "2. Setting up Nix configuration..."
nix run .#vagrant
