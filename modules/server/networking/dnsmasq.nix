{ config, pkgs, lib, ... }:

with lib;
let
  generated = pkgs.callPackage ../../_sources/generated.nix { };
in
{
  options.homelab.dnsmasq = {
    enable = mkEnableOption "Enable dnsmasq";
    blacklist = mkEnableOption "Enable blacklist";
  };
  config = mkIf config.homelab.dnsmasq.enable {
    services.dnsmasq = {
      enable = true;
      package = pkgs.unstable.dnsmasq;
      settings = {
        listen-address = [ "::1" "127.0.0.1" "192.168.1.74" "2620:fe::fe" "2620:fe::9" ];
        interface = "enp3s0";
        domain = "tungsten.lan";
        server = [ "9.9.9.9" "149.112.112.112" ];
        address = [ "/tungsten.home.arpa/192.168.1.74" ]
          ++ lib.optionals (config.homelab.caddy && config.homelab.sonarr) [ "/sonarr.home.arpa/192.168.1.74" ]
          ++ lib.optionals (config.homelab.caddy && config.homelab.radarr) [ "/radarr.home.arpa/192.168.1.74" ]
          ++ lib.optionals (config.homelab.caddy && config.homelab.prowlarr) [ "/prowlarr.home.arpa/192.168.1.74" ]
          ++ lib.optionals (config.homelab.caddy && config.homelab.sabnzbd) [ "/sab.home.arpa/192.168.1.74" ]
          ++ lib.optionals (config.homelab.caddy && config.homelab.bazarr) [ "/bazarr.home.arpa/192.168.1.74" ]
          ++ lib.optionals (config.homelab.caddy && config.homelab.grafana) [ "/grafana.home.arpa/192.168.1.74" ]
          ++ lib.optionals (config.homelab.caddy && config.homelab.grafana) [ "/prometheus.home.arpa/192.168.1.74" ];
      };
      extraConfig = lib.mkIf (config.homelab.dnsmasq.blacklist) (builtins.readFile generated.dnsblacklist.src);
    };
    networking.firewall.allowedTCPPorts = [ 53 ];
    networking.firewall.allowedUDPPorts = [ 53 ];
  };
}
