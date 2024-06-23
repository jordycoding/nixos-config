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
    unbound = {
      enable = mkEnableOption "Enable unbound";
      blacklist = mkEnableOption "Enable adblock blacklist";
    };
    caddy = mkEnableOption "Enable Caddy";
    cockpit = mkEnableOption "Enable Cockpit";
    bazarr = mkEnableOption "Enable Bazarr";
    avahi = mkEnableOption "Enable avahi";
    dyndns = mkEnableOption "Enable ddclient for dynamicdns";
    gitea = mkEnableOption "Enable gitea";
    syncthing = mkEnableOption "Enable syncthing";
    grafana = mkEnableOption "Enable grafana";
    openrgb = mkEnableOption "Enable OpenRGB";
    ollama = mkEnableOption "Enable Ollama";
    keycloak = mkEnableOption "Enable Keycloak";
    ldap = mkEnableOption "Enable LDAP";
    freshrss = mkEnableOption "Enable FreshRSS";
    miniflux = mkEnableOption "Enable MiniFlux";
    matrix = {
      enable = mkEnableOption "Enable Matrix Synapse server";
      createDb = mkEnableOption "Create Postgres database for Matrix";
      dbPasswordFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = "/run/secrets/matrixDbPass";
        description = "File containing matrix database password";
      };
    };
  };

  config = {
    services.postgresql.enable = true;
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
    ./unbound.nix
    ./openrgb.nix
    ./ollama.nix
    ./keycloak.nix
    ./ldap.nix
    ./freshrss.nix
    ./miniflux.nix
    ./matrix.nix
  ];
}
