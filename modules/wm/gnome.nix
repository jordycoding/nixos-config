{ config, pkgs, lib, ... }:

lib.mkIf (config.shell.gnome)
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    tilix
    gnome.gnome-tweaks
    gnome.geary
    gnome.gnome-boxes
    gnome.dconf-editor
    ulauncher
    wmctrl
    foliate
    celluloid
    blackbox-terminal
    gjs
    cambalache
    gnome-network-displays
    gnome-browser-connector
    # gradience
    impression
    fragments
    adw-gtk3
  ];
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  systemd.user.services."1password" = {
    description = "Start 1Password minimized";
    documentation = [ "https://1password.com/" ];
    wantedBy = [ "graphical-session.target" ];
    enable = true;
    path = [ pkgs._1password-gui ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      restartSec = 1;
      ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
    };
  };
}
