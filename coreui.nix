{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox
    discord
    libreoffice
    thunderbird
    _1password-gui
    _1password
  ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
