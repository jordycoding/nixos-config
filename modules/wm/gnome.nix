{ config, pkgs, lib, inputs, ... }:

lib.mkIf (config.shell.gnome)
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    tilix
    gnome-tweaks
    geary
    gnome-boxes
    dconf-editor
    ulauncher
    wmctrl
    foliate
    celluloid
    # blackbox-terminal
    gjs
    cambalache
    gnome-network-displays
    gnome-browser-connector
    # gradience
    impression
    fragments
    adw-gtk3
    mission-center
    gnome-firmware
    fractal
    newsflash
    matugen
    glib
    switcheroo
    dynamic-wallpaper
    delfin
    pika-backup
  ];
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  systemd.user.services = {
    "1password" = {
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
    "proton-bridge" = {
      description = "Proton bridge";
      enable = true;
      script = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive --log-level info";
      wantedBy = [ "graphical-session.target" ];
    };
  };
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
  ]);
}
