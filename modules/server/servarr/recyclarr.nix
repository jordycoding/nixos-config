{ config, pkgs, lib, ... }:

with lib;
{
  options.homelab.recyclarr = mkEnableOption "Enable Recyclarr";
  config = mkIf config.homelab.prowlarr {
    environment.systemPackages = with pkgs; [
      pkgs.unstable.recyclarr
    ];
  };
}
