{
  disko.devices = {
    disk.main = {
      type = "disk";
      # device = "/dev/disk/by-id/someidhere";
      device = "/dev/vda";

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
