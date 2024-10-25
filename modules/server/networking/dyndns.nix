{ config, pkgs, lib, ... }:

with lib;
{
  options.homelab.dyndns = mkEnableOption "Enable Dyndns";
  config = mkIf config.homelab.dyndns {
    services.ddclient = {
      enable = true;
      use = "web, web=dynamicdns.park-your-domain.com/getip";
      protocol = "namecheap";
      server = "dynamicdns.park-your-domain.com";
      username = "alkema.co";
      passwordFile = "/run/agenix/ddPassword";
      domains = [ "*" "@" ];
    };
  };
}
