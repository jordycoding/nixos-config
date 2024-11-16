{ config, lib, ... }:

with lib;
{
  options.homelab.titleCardMaker = mkEnableOption "Enable TitleCardMaker";
  config = mkIf config.homelab.titleCardMaker {
    users.users.tcm = {
      group = "media";
      isSystemUser = true;
    };

    systemd.tmpfiles.rules = [
      "d /mnt/Vault/Data/Titlecardmaker 0770 root media - -"
      "d /mnt/Vault/Data/Titlecardmaker/config 0770 root media - -"
      "d /mnt/Vault/Data/Titlecardmaker/log 0770 root media - -"
    ];

    virtualisation.oci-containers.containers.titlecardmaker = {
      image = "collinheist/titlecardmaker:latest";
      volumes = [
        "/mnt/Vault/Data/Titlecardmaker/config:/config"
        "/mnt/Vault/Data/Titlecardmaker/log:/maker/logs"
        "/mnt/Media/Series:/series"
        "/mnt/Media/Movies:/movies"
        "/mnt/Media/Anime:/anime"
      ];
      environment = {
        TCM_MISSING = "/config/missing.yml";
        TCM_RUNTIME = "22:00";
        TCM_FREQUENCY = "12h";
        PUID = "978";
        PGID = "996";
      };
      extraOptions = [ "--network=host" ];
    };
  };
}
