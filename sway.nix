{ pkgs, ... }:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swayidle
      swaylock
      rofi
      waybar
      grim
      slurp
      alacritty
      wlogout
      mako
      playerctl
      xfce.thunar
      stow
      wl-clipboard
      gnome.zenity
      pavucontrol
      xdg-utils
      xdg-user-dirs
      xdg-desktop-portal
      xdg-desktop-portal-wlr
    ];
  };
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
