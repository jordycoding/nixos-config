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
      "d /mnt/Ssd/Immich 0770 jordy root - -"
      "d /mnt/Ssd/Immich/photos 0770 jordy root - -"
      "d /mnt/Ssd/Immich/appdata 0770 jordy root - -"
      "d /mnt/Ssd/Immich/appdata/pgsql 0770 jordy root - -"
      "d /mnt/Ssd/Immich/appdata/model-cache 0770 jordy root - -"
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
        image = "docker.io/redis:6.2-alpine@sha256:e3b17ba9479deec4b7d1eeec1548a253acc5374d68d3b27937fcfe4df8d18c7e";
      };

      immich_postgres = {
        image = "docker.io/tensorchord/pgvecto-rs:pg14-v0.2.0@sha256:90724186f0a3517cf6914295b5ab410db9ce23190a2d9d0b9dd6463e3fa298f0";
        environmentFiles = [
          config.homelab.immich.pgEnvFile
        ];
        volumes = [
          "${postgresRoot}:/var/lib/postgresql/data"
        ];
      };
    };

  };
}
