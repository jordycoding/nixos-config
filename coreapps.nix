{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    home-manager
    firefox
    discord
    libreoffice
    thunderbird
    _1password-gui
    _1password
    tmux
    neofetch
  ];
}
