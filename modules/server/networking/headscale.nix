{ config, pkgs, lib, ... }:

with lib;

{
  options.homelab.headscale = mkEnableOption "Enable Headscale";
  config = mkIf config.homelab.headscale {
    environment.systemPackages = with pkgs; [
      ethtool
      networkd-dispatcher
    ];
    age.secrets.headscaleClientSecret = {
      file = ../../../secrets/headscaleClientSecret.age;
      path = "/etc/secrets/headscaleClientSecret";
      owner = "headscale";
      group = "root";
      mode = "770";
    };
    services.headscale = {
      enable = true;
      port = 4040;
      settings = {
        server_url = "https://headscale.alkema.co";
        oidc = {
          issuer = "https://keycloak.alkema.co/realms/master";
          client_id = "headscale";
          client_secret_path = "/etc/secrets/headscaleClientSecret";
          allowed_groups = [ "/vpn" ];
        };
        dns = {
          base_domain = "tailnet.alkema.co";
          nameservers.global = [ "tungsten.tailnet.alkema.co" ];
        };
      };
    };
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
    services.networkd-dispatcher = {
      enable = true;
      rules."50-tailscale" = {
        onState = [ "routable" ];
        script = ''
          ${lib.getExe pkgs.ethtool} -K enp3s0 rx-udp-gro-forwarding on rx-gro-list off
        '';
      };
    };
    networking.interfaces.tailscale0.useDHCP = false;
  };
}
