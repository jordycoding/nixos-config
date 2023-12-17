{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    thunderbird
    protonmail-bridge
    piper
    texlive.combined.scheme-full
    tidal-hifi
    firefox-bin
    nicotine-plus
    qbittorrent
    swayosd
  ];
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  services.udev.packages = with pkgs; [ swayosd ];
  fonts.packages = with pkgs; [
    vistafonts
    open-sans
    corefonts
    jetbrains-mono
    noto-fonts-emoji
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "Ubuntu" "NerdFontsSymbolsOnly" ]; })
  ];
  services.ratbagd.enable = true;
}
