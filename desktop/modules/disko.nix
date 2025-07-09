{ lib, ... }:
let
  #! builtins.getEnv only works with --impure
  targetDevice = builtins.getEnv "TARGET_DEVICE_NAME";
in
assert targetDevice != "";  # This will throw an error if DEVICE_NAME is empty
{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = targetDevice;
      # device = "/dev/vda";
      # device = "/dev/disk/by-id/someidhere";

      content = {
        type = "gpt";  # GPT is still fine for BIOS boot
        partitions = {
          # BIOS Boot Partition (grub legacy boot)
          bios = {
            size = "1M";
            type = "EF02";  # BIOS boot partition type for grub
            content = {
              type = "none";
            };
          };

          # Uncomment for UEFI test
          /*
          boot = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          */

          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
