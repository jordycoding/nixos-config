let
  fqdn = "matrix.alkema.co";
  baseUrl = "https://${fqdn}";
  clientConfig."m.homeserver".base_url = baseUrl;
  serverConfig."m.server" = "${fqdn}:443";
  mkWellKnown = data: ''
    header {
      Access-Control-Allow-Origin "*"
      respond `${builtins.toJSON data}`
    }
  '';
in
{
  services.caddy.virtualHosts = {
    "alkema.co" = {
      extraConfig = ''
        handle /.well-known/matrix/server {
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
        
        handle /_matrix {
            reverse_proxy http://[::1]:8008
        }

        handle /_synapse/client {
            reverse_proxy http://[::1]:8008
        }
      '';
    };
  };

  services.matrix-synapse = {
    enable = true;
    settings.server_name = "alkema.co";
    settings.public_baseurl = baseUrl;

    settings.listeners = [
      {
        port = 8008;
        bind_address = [ "::1" ];
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [{
          names = [ "client" "federation" ];
          compress = true;
        }];
      }
    ];
  };
}
