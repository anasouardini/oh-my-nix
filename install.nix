{ pkgs }:

pkgs.writeShellScriptBin "install-nixos" ''
  set -eux

  nix run github:nix-community/disko -- --mode disko ./disko.nix
  nixos-install --flake .#minimal --no-root-password --impure
''
