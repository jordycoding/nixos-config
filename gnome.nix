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
    wmctrl
  ];
  systemd.user.services."ulauncher" = {
    description = "ulauncher";
    documentation = [ "https://ulauncher.io" ];
    wantedBy = [ "graphical-session.target" ];
    enable = true;
    path = [ pkgs.firefox ];
    serviceConfig = {
      Type = "simple";
      # This is necessary for ulauncher to list all applications correctly
      Environment = "PATH=/run/current-system/sw/bin";
      Restart = "always";
      restartSec = 1;
      ExecStart = "${pkgs.ulauncher}/bin/ulauncher --no-window";
    };
  };
}
