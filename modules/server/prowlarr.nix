{ config, pkgs, lib, ... }:
lib.mkIf (config.homelab.prowlarr)
{
  services.prowlarr = {
    enable = true;
    package = pkgs.unstable.prowlarr;
    openFirewall = true;
  };
}
