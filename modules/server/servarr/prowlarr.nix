{ config, pkgs, lib, ... }:

with lib;
{
  options.homelab.prowlarr = mkEnableOption "Enable Prowlarr";
  config = mkIf config.homelab.prowlarr {
    services.prowlarr = {
      enable = true;
      package = pkgs.unstable.prowlarr;
      openFirewall = true;
    };
  };
}
