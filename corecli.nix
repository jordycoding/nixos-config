{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker-compose
    home-manager
    tmux
    neofetch
    pfetch
    bat
    httpie
    exa
    broot
    bind
    pv
    exfat
    pciutils
  ];
}
