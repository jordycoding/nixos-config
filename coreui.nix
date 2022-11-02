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
  ];
  services.ratbagd.enable = true;
}
