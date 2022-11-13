{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox-wayland
    discord
    libreoffice
    thunderbird
    _1password-gui
    _1password
    piper
    vistafonts
    texlive.combined.scheme-medium
    tidal-hifi
  ];
  services.ratbagd.enable = true;
}
