{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.caddy)
{
  services.caddy = {
    enable = true;
    package = pkgs.unstable.caddy;
    virtualHosts = lib.mkMerge [
      (lib.mkIf (config.homelab.sonarr) {
        "http://sonarr.home.lab" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:8989
          '';
        };
      })
      (lib.mkIf (config.homelab.radarr) {
        "http://radarr.home.lab" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:7878
          '';
        };
      })
      (lib.mkIf (config.homelab.prowlarr) {
        "http://prowlarr.home.lab" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:9696
          '';
        };
      })
      (lib.mkIf (config.homelab.sabnzbd) {
        "http://sab.home.lab" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:8080
          '';
        };
      })
      (lib.mkIf (config.homelab.bazarr) {
        "http://bazarr.home.lab" = {
          extraConfig = ''
            reverse_proxy http://127.0.0.1:6767
          '';
        };
      })
    ];
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
