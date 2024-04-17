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
    dnsmasq = {
      enable = mkEnableOption "Enable dnsmasq";
      blacklist = mkEnableOption "Enable blacklist";
    };
    caddy = mkEnableOption "Enable Caddy";
    cockpit = mkEnableOption "Enable Cockpit";
    bazarr = mkEnableOption "Enable Bazarr";
    avahi = mkEnableOption "Enable avahi";
    dyndns = mkEnableOption "Enable ddclient for dynamicdns";
    gitea = mkEnableOption "Enable gitea";
    syncthing = mkEnableOption "Enable syncthing";
    grafana = mkEnableOption "Enable grafana";
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
    ./avahi.nix
    ./dyndns.nix
    ./gitea.nix
    ./syncthing.nix
    ./grafana.nix
    ./prometheus-scrapes.nix
  ];
}
