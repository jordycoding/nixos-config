{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.grafana)
{
  users.groups.exportarr = { };
  users.users.exportarr = {
    group = "exportarr";
    isSystemUser = true;
  };

  age.secrets.sonarr = {
    file = ../../secrets/sonarrApiKey.age;
    owner = "exportarr";
    group = "exportarr";
    mode = "770";
  };
  age.secrets.radarrApiKey = {
    file = ../../secrets/radarrApiKey.age;
    owner = "exportarr";
    group = "exportarr";
    mode = "770";
  };
  age.secrets.sabApiKey.file = ../../secrets/sabApiKey.age;

  services.grafana = {
    enable = true;
    package = pkgs.unstable.grafana;
    settings = {
      server = {
        http_port = 2342;
        http_addr = "0.0.0.0";
      };
    };
  };
  services.prometheus = {
    enable = true;
    package = pkgs.unstable.prometheus;
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
      };
      zfs.enable = true;
      dnsmasq.enable = true;
      exportarr-sonarr = {
        enable = true;
        package = pkgs.unstable.exportarr;
        user = "exportarr";
        group = "exportarr";
        apiKeyFile = "/run/agenix/sonarr";
        url = "http://127.0.0.1:8989";
      };
      exportarr-radarr = {
        enable = true;
        package = pkgs.unstable.exportarr;
        apiKeyFile = "/run/agenix/radarrApiKey";
        user = "exportarr";
        group = "exportarr";
        url = "http://127.0.0.1:7878";
        port = 9709;
      };
      sabnzbd = {
        enable = true;
        servers = [
          {
            baseUrl = "http://localhost:8080";
            apiKeyFile = "/run/agenix/sabApiKey";
          }
        ];
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 2342 9090 ];
}
