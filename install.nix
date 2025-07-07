{ pkgs }:

pkgs.writeShellScriptBin "install-nixos" ''
  set -eux

  nix run github:nix-community/disko -- --mode disko ./hosts/i5/disko.nix
  nixos-install --flake .#my-host --no-root-password --impure
''
