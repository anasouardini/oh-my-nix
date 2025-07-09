{
  description = "main flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    disko.url = "github:nix-community/disko";
  };

  outputs = { self, nixpkgs, flake-utils, disko, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        nixosConfigurations = {
          minimal = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./stages/minimal/configuration.nix
              disko.nixosModules.disko
            ];
          };
          full = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./stages/full/configuration.nix
              disko.nixosModules.disko
            ];
          };
	};
      });
}
