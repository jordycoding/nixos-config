{ config, lib, pkgs, ... }:
with lib;
let
  generated = pkgs.callPackage ../../../_sources/generated.nix { };
  # Generate the RPZ zone file with conditional entries
  customRpz = pkgs.writeText "rpz-custom.zone" ''
    $TTL 1h
    @ IN SOA localhost. admin.localhost. (
      2024010101 ; Serial
      1h         ; Refresh
      15m        ; Retry
      1w         ; Expire
      1h         ; Minimum TTL
    )
    @ IN NS localhost.

    ; Static entries
    tungsten.home.arpa.    IN A 192.168.1.74

    ; Conditional entries
    ${concatStringsSep "\n" ([
      ""
    ] ++ optionals (config.homelab.caddy && config.homelab.sonarr) [
      "sonarr.home.arpa.    IN A 192.168.1.74"
    ] ++ optionals (config.homelab.caddy && config.homelab.radarr) [
      "radarr.home.arpa.    IN A 192.168.1.74"
    ] ++ optionals (config.homelab.caddy && config.homelab.prowlarr) [
      "prowlarr.home.arpa.  IN A 192.168.1.74"
    ] ++ optionals (config.homelab.caddy && config.homelab.sabnzbd) [
      "sab.home.arpa.       IN A 192.168.1.74"
    ] ++ optionals (config.homelab.caddy && config.homelab.bazarr) [
      "bazarr.home.arpa.    IN A 192.168.1.74"
    ] ++ optionals (config.homelab.caddy && config.homelab.grafana) [
      "grafana.home.arpa.   IN A 192.168.1.74"
      "prometheus.home.arpa. IN A 192.168.1.74"
    ])}
  '';
in
{
  options.homelab.powerdns = {
    enable = mkEnableOption "Enable PowerDNS";
  };
  config = mkIf config.homelab.powerdns.enable {
    # services.powerdns = {
    #   enable = true;
    #   extraConfig = ''
    #     local-address=192.168.1.74:53
    #     launch=gpgsql
    #     gpgsql-host=/var/run/postgresql
    #     gpgsql-dbname=pdns
    #     gpgsql-user=pdns
    #     resolver=[::1]:5300
    #   '';
    # };
    services.pdns-recursor = {
      enable = true;
      # forwardZones = {
      #   "home.arpa" = "192.168.1.74";
      # };
      settings = {
        refresh-on-ttl-perc = 10;
        local-address = [ "192.168.1.74:53" "127.0.0.1:53" ];
        # disable-packetcache = "yes";
      };
      luaConfig = ''
        rpzFile("${generated.rpzblacklist.src}/rpz/pro.plus.txt")
        rpzFile("${customRpz}")
      '';
    };
    # services.postgresql = {
    #   ensureDatabases = [ "pdns" ];
    #   ensureUsers = [
    #     {
    #       name = "pdns";
    #       ensureDBOwnership = true;
    #     }
    #   ];
    # };
    networking.firewall.allowedTCPPorts = [ 53 ];
    networking.firewall.allowedUDPPorts = [ 53 ];
  };
}
