{ config, pkgs, lib, ... }:

with lib;
{
  options.homelab.sonarr = mkEnableOption "Enable Sonarr";

  config = mkIf config.homelab.sonarr {
    users.users.sonarr = {
      extraGroups = [ "media" "download" ];
    };

    services.sonarr = {
      enable = true;
      package = pkgs.unstable.sonarr;
      openFirewall = true;
    };
  };
}
