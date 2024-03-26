{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.sonarr)
{
  services.sonarr = {
    enable = true;
    package = pkgs.unstable.sonarr;
    openFirewall = true;
    group = "media download";
  };
}
