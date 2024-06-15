{ lib, config, pkgs, ... }:

lib.mkIf (config.homelab.miniflux)
{
  age.secrets.mfOauth = {
    file = ../../secrets/mfOauth.age;
    owner = "miniflux";
    group = "miniflux";
  };
  services.miniflux = {
    enable = true;
    adminCredentialsFile = "/run/agenix/mfOauth";
  };
  systemd.services.miniflux.environment = {
    LISTEN_ADDR = lib.mkForce "0.0.0.0:6969";
  };
  networking.firewall.allowedTCPPorts = [ 6969 ];
}
