{ lib, config, pkgs, outputs, ... }:

lib.mkIf (config.shell.kde)
{
  # services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = with pkgs; [
    neochat
  ];
  nixpkgs.overlays = [
    outputs.overlays.kdematerialyou
  ];
}
