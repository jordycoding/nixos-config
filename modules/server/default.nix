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
    plex = mkEnableOption "Enable plex";
    dnsmasq = mkEnableOption "Enable Dnsmasq";
    caddy = mkEnableOption "Enable Caddy";
    cockpit = mkEnableOption "Enable Cockpit";
    bazarr = mkEnableOption "Enable Bazarr";
  };

  imports = [
    ./sonarr.nix
    ./sabnzbd.nix
    ./radarr.nix
    ./prowlarr.nix
    ./recyclarr.nix
    ./samba.nix
    ./jellyfin.nix
    ./plex.nix
    ./dnsmasq.nix
    ./caddy.nix
    ./cockpit.nix
    ./bazarr.nix
    ./vpn.nix
  ];
}
