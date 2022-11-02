{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    tilix
    gnome.gnome-tweaks
    newsflash
    gnome.geary
    adw-gtk3
    ulauncher
    papirus-icon-theme
  ];
}
