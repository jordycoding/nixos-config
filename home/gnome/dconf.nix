{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      "xkb-options" = [ "caps:escape" ];
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      "tap-to-click" = true;
    };
    "org/gnome/desktop/interface" = {
      "show-battery-percentage" = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = "appmenu:minimize,maximize,close";
    };
    "org/gnome/desktop/lockdown" = {
      "disable-lock-screen" = false; # Why is this disabled exactly 
    };
  };
}
