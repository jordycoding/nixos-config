{ config, pkgs, lib, ... }:
with lib;

{
  options.homelab = {
    sonarr = mkEnableOption "Enable Sonarr";
    sabnzbd = mkEnableOption "Enable SABnzbd";
    radarr = mkEnableOption "Enable Radarr";
    samba = mkEnableOption "Enable Samba shares";
    prowlarr = mkEnableOption "Enable Prowlarr";
    recyclarr = mkEnableOption "Enable Recyclarr";
    jellyfin = mkEnableOption "Enable Jellyfin";
  };

  imports = [
    ./sonarr.nix
    ./sabnzbd.nix
    ./radarr.nix
    ./prowlarr.nix
    ./recyclarr.nix
    ./samba.nix
    ./jellyfin.nix
  ];
}
