{ config, pkgs, ... }:

{
  imports = [
    ../../modules/desktop.nix
    ../../modules/users.nix
    ./disko.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "UTC";
  system.stateVersion = "24.05";
}
