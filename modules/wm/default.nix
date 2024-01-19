{ config, pkgs, lib, ... }:
with lib;

{
  options.shell = {
    gnome = mkEnableOption "Enable Gnome";
    hypr = mkEnableOption "Enable Hypr";
    sway = mkEnableOption "Enable Sway";
    kde = mkEnableOption "Enable KDE";
  };
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./kde.nix
    ./sway.nix
  ];
}
