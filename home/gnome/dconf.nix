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
      "favorite-apps" = [ "firefox.desktop" "discord.desktop" "tidal-hifi.desktop" "1password.desktop" "ghostty.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Geary.desktop" "org.gnome.Calendar.desktop" "org.gnome.Settings.desktop" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      "switch-to-workspace-1" = [ "<Super>1" ];
      "switch-to-workspace-2" = [ "<Super>2" ];
      "switch-to-workspace-3" = [ "<Super>3" ];
      "switch-to-workspace-4" = [ "<Super>4" ];
      "move-to-workspace-left" = [ "" ];
      "move-to-workspace-right" = [ "" ];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      "hot-keys" = false;
    };
  };
}
