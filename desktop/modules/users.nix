{ pkgs, ... }:

let
 username = "venego";
in
{
  users.users = {
    ${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];

      # Plaintext: nixos
      hashedPassword = "$6$Pfzg4swkAfWY6LCq$wK8jsmC2jFpmEjeO.gyWVo9bM2NUdzGHBFoHLa4LtB8y3yBOeFiC0QeExB3k3lGGnYqU.Ld8ZJb0Fjzk.VYXW.";
    };
  };

  # Expose username as a reusable option
  users.myUsername = username;

  security.sudo.enable = true;
}
