{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.keycloak)
{
  services.keycloak = {
    enable = true;
    database = {
      type = "postgresql";
      createLocally = true;

      username = "keycloak";
      passwordFile = "/run/agenix/keycloakDbPassword";
    };

    settings = {
      hostname = "keycloak.alkema.co";
      http-port = 38080;
      proxy = "passthrough";
      http-enabled = true;
    };
  };
}
