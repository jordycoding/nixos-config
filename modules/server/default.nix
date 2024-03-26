{ config, pkgs, lib, ... }:
with lib;

{
  options.homelab = {
    sonarr = mkEnabeOption "Enable Sonarr";
    sabnzbd = mkEnableOption "Enable SABnzbd";
    radarr = mkEnableOption "Enable Radarr";
    samba = mkEnableOption = "Enable Samba shares";
  };

  imports = [
    ./sonarr.nix
    ./sabnzbd.nix
    ./radarr.nix
  ];
}
