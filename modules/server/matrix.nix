{ config, pkgs, lib, ... }:
with lib;

let
  fqdn = "matrix.alkema.co";
  baseUrl = "https://${fqdn}";
  clientConfig = {
    "m.homeserver".base_url = baseUrl;
  };
  serverConfig."m.server" = "${fqdn}:443";
  mkWellKnown = data: ''
    header {
      Access-Control-Allow-Origin *
    }
    respond `${builtins.toJSON data}`
  '';
in
{
  services.caddy.virtualHosts = mkIf config.homelab.matrix.enable {
    "alkema.co" = {
      extraConfig = ''
        handle /.well-known/matrix/server {
            ${mkWellKnown serverConfig}
        }

        handle /.well-known/matrix/client {
            ${mkWellKnown clientConfig}
        }
      '';
    };
    "${fqdn}" = {
      extraConfig = ''
        handle / {
            respond "Access denied" 404 {
                close
            }
        }
        
        reverse_proxy /_matrix/* http://[::1]:8008
        reverse_proxy /_synapse/client/* http://[::1]:8008
      '';
    };
  };

  age.secrets.matrixDbPass = {
    file = ../../secrets/matrixDbPass.age;
    owner = "matrix-synapse";
    group = "matrix-synapse";
  };
  age.secrets.matrixSettings = {
    file = ../../secrets/matrixSettings.age;
    owner = "matrix-synapse";
    group = "matrix-synapse";
  };

  services.matrix-synapse = mkIf config.homelab.matrix.enable {
    enable = true;
    settings.server_name = "alkema.co";
    settings.public_baseurl = baseUrl;

    settings.listeners = [
      {
        port = 8008;
        bind_addresses = [ "::1" ];
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [{
          names = [ "client" "federation" ];
          compress = true;
        }];
      }
    ];
    extraConfigFiles = [ "/run/agenix/matrixSettings" ];
  };

  systemd.services.matrixPostgreSQLInit = mkIf config.homelab.matrix.createDb {
    after = [ "postgresql.service" ];
    before = [ "matrix-synapse.service" ];
    bindsTo = [ "postgresql.service" ];
    path = [ config.services.postgresql.package ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "postgres";
      Group = "postgres";
      LoadCredential = [ "db_password:${config.homelab.matrix.dbPasswordFile}" ];
    };
    script = ''
      set -o errexit -o pipefail -o nounset -o errtrace
      shopt -s inherit_errexit

      create_role="$(mktemp)"
      trap 'rm -f "$create_role"' EXIT

      # Read the password from the credentials directory and
      # escape any single quotes by adding additional single
      # quotes after them, following the rules laid out here:
      # https://www.postgresql.org/docs/current/sql-syntax-lexical.html#SQL-SYNTAX-CONSTANTS
      db_password="$(<"$CREDENTIALS_DIRECTORY/db_password")"
      db_password="''${db_password//\'/\'\'}"

      echo "CREATE ROLE \"matrix-synapse\" WITH LOGIN PASSWORD '$db_password' CREATEDB" > "$create_role"
      psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='matrix-synapse'" | grep -q 1 || psql -tA --file="$create_role"
      psql -tAc "SELECT 1 FROM pg_database WHERE datname = 'matrix-synapse'" | grep -q 1 || psql -tAc 'CREATE DATABASE "matrix-synapse" OWNER "matrix-synapse" TEMPLATE template0 LC_COLLATE = "C" LC_CTYPE = "C"'
    '';
  };
}
