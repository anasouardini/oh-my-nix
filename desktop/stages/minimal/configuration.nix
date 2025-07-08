{ config, pkgs, ... }:

{
  imports = [
    ./desktop.nix
    ../../modules/users.nix
    ../../modules/disko.nix
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

  # systemd service for 2nd part of installation
  {
    systemd.services.switch-to-full = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "oneshot";
        User = ${config.users.myUsername};
        ExecStart = "bash <(curl -sL https://raw.githubusercontent.com/anasouardini/oh-my-nix/main/install.sh) desktop full";
        RemainAfterExit = true;
      };
    };
  }
}
