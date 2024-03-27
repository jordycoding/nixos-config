{ config, outputs, pkgs, lib, ... }:

lib.mkIf (config.homelab.jellyfin)
{
  services.jellyfin = {
    enable = true;
    package = pkgs.jellyfin;
    openFirewall = true;
  };
}
