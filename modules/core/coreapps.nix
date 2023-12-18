{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    home-manager
    discord
    webcord
    thunderbird
    tmux
    neofetch
  ];
}
