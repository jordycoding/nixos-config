{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.bazarr)
{
  services.bazarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };
}
