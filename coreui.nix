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
    texlive.combined.scheme-full
    tidal-hifi
  ];
  fonts.fonts = with pkgs; [
    vistafonts
    open-sans
    corefonts
  ];
  services.ratbagd.enable = true;
}
