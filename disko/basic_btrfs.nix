{ disks ? [ "/dev/vda" ], ... }:
{
  disko.devices = {
    disk = {
      main = {
        imageSize = "32G";
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              start = "1M";
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@nixos" = {
                    mountpoint = "/";
                  };
                  "@home" = {
                    mountpoint = "/home";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
