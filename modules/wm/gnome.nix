{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    tilix
    gnome.gnome-tweaks
    gnome.geary
    gnome.gnome-boxes
    adw-gtk3
    ulauncher
    wmctrl
    foliate
    celluloid
    blackbox-terminal
    gjs
    cambalache
    gnome-network-displays
  ];
  # systemd.user.services."ulauncher" = {
  #   description = "ulauncher";
  #   documentation = [ "https://ulauncher.io" ];
  #   wantedBy = [ "graphical-session.target" ];
  #   enable = true;
  #   path = [ pkgs.firefox ];
  #   serviceConfig = {
  #     Type = "simple";
  #     # This is necessary for ulauncher to list all applications correctly
  #     Environment = "PATH=/run/current-system/sw/bin:/home/jordy/.nix-profile/bin";
  #     Restart = "always";
  #     restartSec = 1;
  #     ExecStart = "${pkgs.ulauncher}/bin/ulauncher --no-window";
  #   };
  # };
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