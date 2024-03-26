{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
    gh
    neovim
    rofi
    sway
    thefuck
    alacritty
    mako
    swayidle
    swaylock
    grim
    slurp
    alacritty
    wlogout
    playerctl
    pulseaudio
    wl-clipboard
    gnome.zenity
    pavucontrol
    xdg-utils
    direnv
  ];
}
