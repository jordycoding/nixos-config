{ config, pkgs, lib, ... }:
with lib;

{
  options.homelab = {
    sabnzbd = mkEnableOption "Enable SABnzbd";
    samba = mkEnableOption "Enable Samba shares";
    jellyfin = mkEnableOption "Enable Jellyfin";
    plex = mkEnableOption "Enable plex";
    cockpit = mkEnableOption "Enable Cockpit";
    gitea = mkEnableOption "Enable gitea";
    syncthing = mkEnableOption "Enable syncthing";
    grafana = mkEnableOption "Enable grafana";
    openrgb = mkEnableOption "Enable OpenRGB";
    ollama = mkEnableOption "Enable Ollama";
    keycloak = mkEnableOption "Enable Keycloak";
    ldap = mkEnableOption "Enable LDAP";
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
    calibre = mkEnableOption "Enable Calibre-web";
  };

  config = {
    services.postgresql.enable = true;
  };

  imports = [
    ./sabnzbd.nix
    ./samba.nix
    ./jellyfin.nix
    ./plex.nix
    ./cockpit.nix
    ./gitea.nix
    ./syncthing.nix
    ./grafana.nix
    ./prometheus-scrapes.nix
    ./openrgb.nix
    ./ollama.nix
    ./keycloak.nix
    ./ldap.nix
    ./miniflux.nix
    ./matrix.nix
    ./immich.nix
    ./calibre.nix
    ./unmanic.nix
    ./servarr
    ./networking
    ./titlecardmaker.nix
    ./incus.nix
    ./glance.nix
  ];
}
