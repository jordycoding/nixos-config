{ config, pkgs, lib, ... }:

with lib;
{
  options.homelab.radarr = mkEnableOption "Enable Radarr";
  config = mkIf config.homelab.radarr {
    users.users.radarr = {
      extraGroups = [ "media" "download" ];
    };

    services.radarr = {
      enable = true;
      package = pkgs.unstable.radarr;
      openFirewall = true;
    };
  };
}
