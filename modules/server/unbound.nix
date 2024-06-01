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
        server = {
          interface = [ "::1" "127.0.0.1" "192.168.1.74" ];
        };
        forward-zone = [
          {
            name = "tungsten.home.arpa";
            forward-addr = [ "192.168.1.74" ];
          }
        ]
        ++ optionals (config.homelab.caddy && config.homelab.sonarr) [{
          name = "sonarr.home.arpa";
          forward-addr = [ "192.168.1.74" ];
        }]
        ++ optionals (config.homelab.caddy && config.homelab.radarr) [{
          name = "radarr.home.arpa";
          forward-addr = [ "192.168.1.74" ];
        }]
        ++ optionals (config.homelab.caddy && config.homelab.prowlarr) [{
          name = "prowlarr.home.arpa";
          forward-addr = [ "192.168.1.74" ];
        }]
        ++ optionals (config.homelab.caddy && config.homelab.sabnzbd) [{
          name = "sab.home.arpa";
          forward-addr = [ "192.168.1.74" ];
        }]
        ++ optionals (config.homelab.caddy && config.homelab.bazarr) [{
          name = "bazarr.home.arpa";
          forward-addr = [ "192.168.1.74" ];
        }]
        ++ optionals (config.homelab.caddy && config.homelab.grafana) [{
          name = "grafana.home.arpa";
          forward-addr = [ "192.168.1.74" ];
        }]
        ++ optionals (config.homelab.caddy && config.homelab.grafana) [{
          name = "prometheus.home.arpa";
          forward-addr = [ "192.168.1.74" ];
        }];
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
}
