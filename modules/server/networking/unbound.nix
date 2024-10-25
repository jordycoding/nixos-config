{ config, pkgs, lib, ... }:

with lib;
let
  generated = pkgs.callPackage ../../../_sources/generated.nix { };
in
{
  options.homelab.unbound = {
    enable = mkEnableOption "Enable unbound";
    blacklist = mkEnableOption "Enable adblock blacklist";
  };
  config = mkIf config.homelab.unbound.enable {
    services.unbound = mkMerge [
      ({
        enable = true;
        package = pkgs.unstable.unbound;
        settings = {
          server = {
            interface = [ "::1" "127.0.0.1" "192.168.1.74" ];
            access-control = "192.168.1.0/24 allow";
            local-data = [
              "\"tungsten.home.arpa A 192.168.1.74\""
            ]
            ++ optionals (config.homelab.caddy && config.homelab.sonarr) [
              "\"sonarr.home.arpa A 192.168.1.74\""
            ]
            ++ optionals (config.homelab.caddy && config.homelab.radarr) [
              "\"radarr.home.arpa A 192.168.1.74\""
            ]
            ++ optionals (config.homelab.caddy && config.homelab.prowlarr) [
              "\"prowlarr.home.arpa A 192.168.1.74\""
            ]
            ++ optionals (config.homelab.caddy && config.homelab.sabnzbd) [
              "\"sab.home.arpa A 192.168.1.74\""
            ]
            ++ optionals (config.homelab.caddy && config.homelab.bazarr) [
              "\"bazarr.home.arpa A 192.168.1.74\""
            ]
            ++ optionals (config.homelab.caddy && config.homelab.grafana) [
              "\"grafana.home.arpa A 192.168.1.74\""
            ]
            ++ optionals (config.homelab.caddy && config.homelab.grafana) [
              "\"prometheus.home.arpa A 192.168.1.74\""
            ];
          };
        };
      })
      (mkIf config.homelab.unbound.blacklist {
        settings = {
          include = "${generated.unboundblacklist.src}";
        };
      })
    ];
    networking.firewall.allowedTCPPorts = [ 53 ];
    networking.firewall.allowedUDPPorts = [ 53 ];
  };
}
