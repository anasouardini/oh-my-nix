{
  description = "NixOS flake with i3 + polybar + brave + alacritty";

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
        packages.install = import ./install.nix { inherit pkgs; };

        nixosConfigurations.my-host = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/my-host/configuration.nix
            disko.nixosModules.disko
          ];
        };
      });
}
