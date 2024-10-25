{ config, pkgs, lib, ... }:

with lib;
{
  options.homelab.bazarr = mkEnableOption "Enable Bazarr";
  config = mkIf config.homelab.bazarr {
    services.bazarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
  };
}
