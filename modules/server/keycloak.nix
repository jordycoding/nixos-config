{ config, pkgs, lib, ... }:

let
  keywind = builtins.path { path = ../../keywind.jar; name = "keywind.jar"; };
in
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
      proxy-headers = "forwarded|xforwarded";
      http-enabled = true;
    };
    plugins = [
      keywind
    ];
  };
}
