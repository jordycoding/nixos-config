{ config, pkgs, lib, ... }:
with lib;

{
  options.homelab.immich = mkEnableOption "Enable Immich";

  config = mkIf (config.homelab.immich) {
    systemd.tmpfiles.rules = [
      "d /mnt/Vault/Data/Immich 0770 immich immich - -"
    ];

    services.immich = {
      enable = true;
      package = pkgs.unstable.immich;
      mediaLocation = "/mnt/Vault/Data/Immich";
    };
  };
}
