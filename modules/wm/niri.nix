{ lib, config, inputs, pkgs, ... }:

lib.mkIf (config.shell.niri)
{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;
  environment.systemPackages = with pkgs; [
    fuzzel
    swww
    waypaper
    rofi-wayland
  ];
}
