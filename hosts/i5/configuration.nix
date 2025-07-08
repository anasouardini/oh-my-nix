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

  swapDevices = [
    {
      device = "/swapfile";
      size = 4096; # Size in MB
    }
  ];
  # ensure the swap file is created
  systemd.tmpfiles.rules = [
    "f /swapfile 600 root root 0"
  ];
  # if using hibernate
  boot.kernelParams = [ "resume=/swapfile" ];
}
