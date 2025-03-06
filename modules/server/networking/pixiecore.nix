{ config, lib, pkgs, outputs, ... }:

with lib;
let netboot = outputs.nixosConfigurations.netboot.config.system.build;
in
{
  options.homelab.pixiecore = mkEnableOption "Enable Pixiecore";
  config = mkIf config.homelab.pixiecore {
    services.pixiecore = {
      enable = true;
      openFirewall = true;
      mode = "boot";
      kernel = "${netboot.kernel}/bzImage";
      initrd = "${netboot.netbootRamdisk}/initrd";
      cmdLine = "init=${netboot.toplevel}/init loglevel=4";
      port = 3030;
      dhcpNoBind = true;
    };
  };
}
