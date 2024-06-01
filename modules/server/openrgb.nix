{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.openrgb)
{
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.unstable.openrgb;
  };
}
