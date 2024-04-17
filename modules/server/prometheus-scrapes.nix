{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.grafana)
{
  services.prometheus = {
    scrapeConfigs = [
      {
        job_name = "tungsten";
        static_configs = [{
          targets = [
            "127.0.0.1:${toString config.services.prometheus.exporters.node.port}"
            "127.0.0.1:${toString config.services.prometheus.exporters.zfs.port}"
            "127.0.0.1:${toString config.services.prometheus.exporters.exportarr-sonarr.port}"
            "127.0.0.1:${toString config.services.prometheus.exporters.exportarr-radarr.port}"
          ];
        }];
      }
    ];
  };
}
