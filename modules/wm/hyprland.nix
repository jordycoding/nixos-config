{ config, lib, pkgs, ... }:

lib.mkIf (config.shell.hypr)
{
  environment.systemPackages = with pkgs; [
    libsForQt5.polkit-kde-agent
  ];
  services = {
    upower.enable = true;
    power-profiles-daemon.enable = true;
  };
  security.pam.services.swaylock = { };
}
