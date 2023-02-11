{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    home-manager
    firefox-wayland
    discord
    libreoffice
    thunderbird
    _1password-gui
    _1password
    tmux
    neofetch
  ];
}
