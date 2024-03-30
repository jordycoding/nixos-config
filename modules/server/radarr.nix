{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.radarr)
{
  users.users.radarr = {
    extraGroups = [ "media" "download" ];
  };

  services.radarr = {
    enable = true;
    package = pkgs.unstable.radarr;
    openFirewall = true;
  };
}
