{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    libreoffice-fresh
    thunderbird
    protonmail-bridge
    piper
    texlive.combined.scheme-full
    tidal-hifi
    firefox-bin
    nicotine-plus
    qbittorrent
    webcord
  ];
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  fonts.packages = with pkgs; [
    vistafonts
    open-sans
    corefonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "Ubuntu" ]; })
  ];
  services.ratbagd.enable = true;
}
