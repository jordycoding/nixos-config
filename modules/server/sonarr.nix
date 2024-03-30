{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.sonarr)
{
  users.users.sonarr = {
    extraGroups = [ "media" "download" ];
  };

  services.sonarr = {
    enable = true;
    package = pkgs.unstable.sonarr;
    openFirewall = true;
  };
}
