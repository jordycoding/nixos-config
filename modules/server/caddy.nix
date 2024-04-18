{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.caddy)
{
  services.caddy = {
    enable = true;
    package = pkgs.unstable.caddy;
    virtualHosts = lib.mkMerge [
      (lib.mkIf (config.homelab.sonarr) {
        "http://sonarr.home.arpa" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:8989
          '';
        };
      })
      (lib.mkIf (config.homelab.radarr) {
        "http://radarr.home.arpa" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:7878
          '';
        };
      })
      (lib.mkIf (config.homelab.prowlarr) {
        "http://prowlarr.home.arpa" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:9696
          '';
        };
      })
      (lib.mkIf (config.homelab.sabnzbd) {
        "http://sab.home.arpa" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:8080
          '';
        };
      })
      (lib.mkIf (config.homelab.bazarr) {
        "http://bazarr.home.arpa" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:6767
          '';
        };
      })
      (lib.mkIf (config.homelab.grafana) {
        "http://grafana.home.arpa" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:2342
          '';
        };
      })
      (lib.mkIf (config.homelab.grafana) {
        "http://prometheus.home.arpa" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:9090
          '';
        };
      })
      (lib.mkIf (config.homelab.gitea) {
        "https://gitea.alkema.co" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:3000
          '';
        };
      })
      (lib.mkIf (config.homelab.syncthing) {
        "https://syncthing.alkema.co" = {
          extraConfig = ''
            reverse_proxy http://localhost:8384 {
                header_up Host {upstream_hostport}
            }
          '';
        };
      })
      (lib.mkIf (config.homelab.jellyfin) {
        "https://jellyfin.alkema.co" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:8096
          '';
        };
      })
    ];
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
