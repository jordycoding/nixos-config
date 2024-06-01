{ config, pkgs, lib, ... }:

with lib;
let
  generated = pkgs.callPackage ../../_sources/generated.nix { };
in
lib.mkIf (config.homelab.unbound.enable)
{
  services.unbound = mkMerge [
    ({
      enable = true;
      package = pkgs.unstable.unbound;
      settings = {
        forward-zone = [
          {
            name = "tungsten.home.arpa";
            forward-addr = "192.168.1.74";
          }
        ]
        ++ optionals (homelab.caddy && homelab.sonarr) {
          name = "sonarr.home.arpa";
          forward-addr = "192.168.1.74";
        }
        ++ optionals (homelab.caddy && homelab.radarr) {
          name = "radarr.home.arpa";
          forward-addr = "192.168.1.74";
        }
        ++ optionals (homelab.caddy && homelab.prowlarr) {
          name = "prowlarr.home.arpa";
          forward-addr = "192.168.1.74";
        }
        ++ optionals (homelab.caddy && homelab.sabnzbd) {
          name = "sab.home.arpa";
          forward-addr = "192.168.1.74";
        }
        ++ optionals (homelab.caddy && homelab.bazarr) {
          name = "bazarr.home.arpa";
          forward-addr = "192.168.1.74";
        }
        ++ optionals (homelab.caddy && homelab.grafana) {
          name = "grafana.home.arpa";
          forward-addr = "192.168.1.74";
        }
        ++ optionals (homelab.caddy && homelab.grafana) {
          name = "prometheus.home.arpa";
          forward-addr = "192.168.1.74";
        };
      };
    })
    (mkIf homelab.unbound.blacklist {
      settings = {
        include = "${generated.unboundblacklist.src}";
      };
    })
  ];
}
