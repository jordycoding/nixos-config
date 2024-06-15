{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.freshrss)
{
  services.freshrss = {
    enable = true;
    database.type = "sqlite";
    virtualHost = null;
    authType = "form";
    baseUrl = "https://freshrss.alkema.co";
    pool = "none";
    passwordFile = pkgs.writeText "pass" "kuthoer";
  };
  # services.postgresql = {
  #   ensureDatabases = [
  #     config.services.freshrss.database.name
  #   ];
  #   ensureUsers = [
  #     {
  #       name = config.services.freshrss.user;
  #       ensureDBOwnership = true;
  #     }
  #   ];
  #   identMap = "map-name-0 freshrss freshrss";
  # };
  services.phpfpm.pools = {
    freshrss = {
      user = "freshrss";
      settings = {
        "listen.owner" = "caddy";
        "listen.group" = "caddy";
        "listen.mode" = "0600";
        "pm" = "dynamic";
        "pm.max_children" = 32;
        "pm.max_requests" = 500;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 2;
        "pm.max_spare_servers" = 5;
        "catch_workers_output" = true;
      };
      phpEnv = {
        DATA_PATH = "${config.services.freshrss.dataDir}";
      };
    };
  };
}
