{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.sabnzbd)
{
  services.sabnzbd = {
    enable = true;
    package = pkgs.unstable.sabnzbd;
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
