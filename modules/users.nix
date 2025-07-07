{ pkgs, ... }:

{
  users.users.venego = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];

    # Plaintext: nixos
    hashedPassword = "$6$Pfzg4swkAfWY6LCq$wK8jsmC2jFpmEjeO.gyWVo9bM2NUdzGHBFoHLa4LtB8y3yBOeFiC0QeExB3k3lGGnYqU.Ld8ZJb0Fjzk.VYXW.";
  };

  security.sudo.enable = true;
}
