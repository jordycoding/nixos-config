{ lib, config, pkgs, ... }:

lib.mkIf (config.shell.kde)
{
  services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
}
