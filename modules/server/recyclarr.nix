{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.recyclarr)
{
  environment.systemPackages = with pkgs; [
    pkgs.unstable.recyclarr
  ];
}
