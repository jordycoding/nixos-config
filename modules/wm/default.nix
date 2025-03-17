{ config, pkgs, lib, ... }:
with lib;

{
  options.shell = {
    gnome = mkEnableOption "Enable Gnome";
    hypr = mkEnableOption "Enable Hypr";
    sway = mkEnableOption "Enable Sway";
    kde = mkEnableOption "Enable KDE";
    niri = mkEnableOption "Enable Niri";
  };
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./kde.nix
    ./sway.nix
    ./niri.nix
  ];
}
