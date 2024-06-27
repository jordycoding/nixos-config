{ config, pkgs, lib, ... }:
with lib;

let
  immichVersion = "release";
  immichRoot = "/mnt/Ssd/Data/Immich";
  immichPhotos = "${immichRoot}/photos";
  immichAppdataRoot = "${immichRoot}/appdata";
  postgresRoot = "${immichAppdataRoot}/pgsql";
in
{
  options.homelab.immich = {
    enable = mkEnableOption "Enable Immich";
    immichEnvFile = mkOption {
      type = types.path;
    };
    pgEnvFile = mkOption {
      type = types.path;
    };
  };

  config = mkIf (config.homelab.immich.enable) {
    systemd.tmpfiles.rules = [
      "d /mnt/Ssd/Data/Immich 0770 jordy jordy - -"
    ];

    virtualisation.oci-containers.containers = {
      immich_server = {
        image = "ghcr.io/immich-app/immich-server:${immichVersion}";
        ports = [ "127.0.0.1:2283:3001" ];
        cmd = [ "start.sh" "immich" ];
        environment = {
          IMMICH_VERSION = immichVersion;
          DB_HOSTNAME = "immich_postgres";
          REDIS_HOSTNAME = "immich_redis";
        };
        environmentFiles = [
          config.homelab.immich.immichEnvFile
        ];
      };
      volumes = [
        "${immichPhotos}:/usr/src/app/upload"
        "/etc/localtime:/etc/locatime:ro"
      ];
    };

    immich_microservices = {
      image = "ghcr.io/immich-app/immich-server:${immichVersion}";
      cmd = [ "start.sh" "microservices" ];
      environment = {
        IMMICH_VERSION = immichVersion;
        DB_HOSTNAME = "immich_postgres";
        REDIS_HOSTNAME = "immich_redis";
      };
      environmentFiles = [
        config.homelab.immich.immichEnvFile
      ];
      volumes = [
        "${immichPhotos}:/usr/src/app/upload"
        "/etc/localtime:/etc/localtime:ro"
      ];
    };

    immich_machine_learning = {
      image = "ghcr.io/immich-app/immich-machine-learning:${immichVersion}";
      environment = {
        IMMICH_VERSION = immichVersion;
      };
      volumes = [
        "${immichAppdataRoot}/model-cache:/cache"
      ];
    };

    immich_redis = {
      image = "redis:6.2-alpine@sha256:d6c2911ac51b289db208767581a5d154544f2b2fe4914ea5056443f62dc6e900";
    };

    immich_postgres = {
      image = "tensorchord/pgvecto-rs:pg14-v0.2.0";
      environmentFiles = [
        config.homelab.immich.pgEnvFile
      ];
      volumes = [
        "${postgresRoot}:/var/lib/postgresql/data"
      ];
    };
  };
}
