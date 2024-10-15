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
      (lib.mkIf (config.homelab.keycloak) {
        "https://keycloak.alkema.co" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:${toString config.services.keycloak.settings.http-port}
          '';
        };
      })
      (lib.mkIf (config.homelab.freshrss) {
        "https://freshrss.alkema.co" = {
          extraConfig = ''
            root * "${config.services.freshrss.package}/p"
             @php path_regexp ^.+?\.php(/.*)?$
             @split path_regexp ^(.+\.php)(/.*)$
             handle @php {
                 php_fastcgi ${config.services.phpfpm.pools."freshrss".socket}
             }
            
            handle / {
                try_files {path} {path}/index.php index.php
                file_server {
                    index index.php index.html index.htm
                }
            }
          '';
        };
      })
      (lib.mkIf (config.homelab.miniflux) {
        "https://miniflux.alkema.co" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:6969 {
                header_up Host {upstream_hostport}
            }
          '';
        };
      })
      (lib.mkIf (config.homelab.immich.enable) {
        "https://immich.alkema.co" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:2283
          '';
        };
      })
      (lib.mkIf (config.homelab.calibre) {
        "https://calibre.alkema.co" = {
          extraConfig = ''
            reverse_proxy localhost:8083 {
                 header_up X-Scheme https
            }
          '';
        };
      })
    ];
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
