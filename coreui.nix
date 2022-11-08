{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox
    discord
    libreoffice
    thunderbird
    _1password-gui
    _1password
    piper
    vistafonts
    texlive.combined.scheme-medium
  ];
  services.ratbagd.enable = true;
}
