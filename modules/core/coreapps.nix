{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    home-manager
    discord
    webcord
    thunderbird
    _1password-gui
    _1password
    tmux
    neofetch
  ];
}
