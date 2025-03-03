{ config, pkgs, lib, ... }:
with lib;

let
  immichVersion = "release";
  immichRoot = "/mnt/Ssd/Immich";
  immichPhotos = "${immichRoot}/photos";
  immichAppdataRoot = "${immichRoot}/appdata";
  postgresRoot = "${immichAppdataRoot}/pgsql";
in
{
  options.homelab.immich = mkEnableOption "Enable Immich";

  config = mkIf (config.homelab.immich.enable) {
    systemd.tmpfiles.rules = [
      "d /mnt/Vault/Data/Immich 0770 immich immich - -"
    ];

    services.immich = {
      enable = true;
      package = pkgs.unstable.immich;
      mediaLocation = "/mnt/vault/Data/Immich";
    };
  };
}
