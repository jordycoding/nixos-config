{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.bazarr)
{
  services.bazarr = {
    enable = true;
    package = pkgs.unstable.bazarr;
    openFirewall = true;
    group = "media";
  };
}
