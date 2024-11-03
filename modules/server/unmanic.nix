{ config, pkgs, lib, ... }:
with lib;
{
  options.homelab.unmanic = mkEnableOption "Enable Unmanic";
  config = mkIf (config.homelab.unmanic) {
    users.users.unmanic = {
      extraGroups = [ "media" ];
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
        PUID = "${config.users.users.unmanic.uid}";
        PGID = "${config.users.groups.media.gid}";
      };
      volumes = [
        "/mnt/Vault/Data/Unmanic/config:/config"
        "/mnt/Vault/Data/Unmanic/tmp:/tmp/unmanic"
        "/mnt/Media/Series:/series"
        "/mnt/Media/Movies:/movies"
        "/mnt/Media/Anime:/anime"
      ];
    };
    networking.firewall.allowedTCPPorts = [ 8888 ];
  };
}
