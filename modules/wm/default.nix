{ config, pkgs, lib, ... }:
with lib;

{
  options.shell = {
    gnome = mkEnableOption "Gnome";
    hypr = mkEnableOption "Hypr";
    sway = mkEnableOption "Sway";
    kde = mkEnableOption "KDE";
  };
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./kde.nix
    ./sway.nix
  ];
}
