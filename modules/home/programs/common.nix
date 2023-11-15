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
    waybar
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
    xdg-user-dirs
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    rnix-lsp
    jdt-language-server
    direnv
  ];
}