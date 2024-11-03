{ config, pkgs, lib, ... }:
with lib;
{
  options.homelab.unmanic = mkEnableOption "Enable Unmanic";
  config = mkIf (config.homelab.unmanic) {
    users.groups.unmanic = { };
    users.users.unmanic = {
      group = "unmanic";
      extraGroups = [ "media" ];
      isSystemUser = true;
    };

    systemd.tmpfiles.rules = [
      "d /mnt/Vault/Data/Unmanic 0770 unmanic root - -"
      "d /mnt/Vault/Data/Unmanic/tmp 0770 unmanic root - -"
      "d /mnt/Vault/Data/Unmanic/config 0770 unmanic root - -"
    ];

    virtualisation.oci-containers.containers.unmanic = {
      image = "josh5/unmanic";
      ports = [ "0.0.0.0:8888:8888" ];
      environment = {
        PUID = "979";
        PGID = "996";
      };
      volumes = [
        "/mnt/Vault/Data/Unmanic/config:/config"
        "/mnt/Vault/Data/Unmanic/tmp:/tmp/unmanic"
        "/mnt/Media/Series:/series"
        "/mnt/Media/Movies:/movies"
        "/mnt/Media/Anime:/anime"
      ];
      extraOptions = [ "--device=/dev/dri" ];
    };
    networking.firewall.allowedTCPPorts = [ 8888 ];
  };
}
