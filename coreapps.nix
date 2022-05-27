{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
