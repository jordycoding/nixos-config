{ config, pkgs, lib, ... }:

with lib;
{
  options.homelab.dyndns = mkEnableOption "Enable Dyndns";
  config = mkIf config.homelab.dyndns {
    services.ddclient = {
      enable = true;
      # As of 21-03-25 namecheaps dyndns thingy seems to be broken
      # This uses ipify by default, which should be fine too
      # usev4 = "webv4, webv4=dynamicdns.park-your-domain.com/getip";
      protocol = "namecheap";
      server = "dynamicdns.park-your-domain.com";
      username = "alkema.co";
      passwordFile = "/run/agenix/ddPassword";
      domains = [ "*" "@" ];
    };
  };
}
