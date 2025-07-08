{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.i3.enable = true;
  };

  services.xserver.windowManager.i3 = {
    package = pkgs.i3;
  };

  services.polybar.enable = true;

  programs.alacritty.enable = true;
  programs.brave.enable = true;
  programs.i3status.enable = false;

  fonts.packages = with pkgs; [
    dejavu_fonts
    terminus_font
  ];

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    alacritty
    brave
    polybar
    i3
  ];

  networking.networkmanager.enable = true;
}
