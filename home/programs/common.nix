{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
    gh
    neovim
    rofi
    sway
    # thefuck
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
    zenity
    pavucontrol
    xdg-utils
    direnv
    papirus-folders
  ];
}
