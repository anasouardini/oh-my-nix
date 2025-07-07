#!/bin/bash
set -eux

REPO_URL="https://github.com/YOURUSERNAME/nixos-flake"

cd /mnt
git clone "$REPO_URL" nixos-flake
cd nixos-flake

nix develop .#install -c install-nixos
