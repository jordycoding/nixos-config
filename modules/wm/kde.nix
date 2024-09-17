{ lib, config, pkgs, outputs, ... }:

lib.mkIf (config.shell.kde)
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  nixpkgs.overlays = [
    outputs.overlays.kdematerialyou
  ];
}
