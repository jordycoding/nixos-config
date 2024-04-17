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
      };
      exportarr-radarr = {
        enable = true;
        apiKeyFile = "/run/agenix/radarrApiKey";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 2342 9090 ];
}
