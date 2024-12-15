{ config, pkgs, lib, osConfig, ... }:

with lib;
{
  systemd.user.tmpfiles.rules = [
    "d /home/jordy/.config/gtk-3.0-gnome 0755 jordy -"
    "d /home/jordy/.config/gtk-3.0-kde 0755 jordy -"
    "d /home/jordy/.config/gtk-4.0-gnome 0755 jordy -"
    "d /home/jordy/.config/gtk-4.0-kde 0755 jordy -"
  ] ++ optionals (osConfig.shell.kde) [
    "L+ /home/jordy/.config/gtk-3.0 - - - - /home/jordy/.config/gtk-3.0-kde"
  ] ++ optionals (osConfig.shell.gnome) [
    "L+ /home/jordy/.config/gtk-3.0 - - - - /home/jordy/.config/gtk-3.0-gnome"
  ] ++ optionals (osConfig.shell.kde) [
    "L+ /home/jordy/.config/gtk-4.0 - - - - /home/jordy/.config/gtk-4.0-kde"
  ] ++ optionals (osConfig.shell.gnome) [
    "L+ /home/jordy/.config/gtk-4.0 - - - - /home/jordy/.config/gtk-4.0-gnome"
  ];
}
