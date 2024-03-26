{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.radarr)
{
  services.radarr = {
    enable = true;
    package = pkgs.unstable.radarr;
    openFirewall = true;
  };
}
