#!/bin/bash
set -eux

REPO_URL="https://github.com/anasouardini/oh-my-nix"

cd /mnt
git clone "$REPO_URL" oh-my-nix
cd oh-my-nix

nix develop .#install -c install-nixos
