{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.sabnzbd)
{
  services.sabnzbd = {
    enable = true;
    package = pkgs.unstable.sabnzbd;
    group = "download";
  };
}
