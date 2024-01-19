{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      "xkb-options" = [ "caps:escape" ];
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      "tap-to-click" = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = "appmenu:minimize,maximize,close";
    };
    "org/gnome/desktop/lockdown" = {
      "disable-lock-screen" = false; # Why is this disabled exactly 
    };
    "org/gnome/desktop/interface" = {
      "show-battery-percentage" = true;
      "gtk-theme" = "adw-gtk3-dark";
      "color-scheme" = "prefer-dark";
      "icon-theme" = "Papirus-Dark";
    };
    "org/gnome/shell" = {
      "favorite-apps" = [ "firefox.desktop" "discord.desktop" "tidal-hifi.desktop" "1password.desktop" "com.raggesilver.BlackBox.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Geary.desktop" "org.gnome.Calendar.desktop" "org.gnome.Settings.desktop" ];
    };
  };
}
