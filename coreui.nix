{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox-wayland
    discord
    libreoffice
    thunderbird
    piper
    texlive.combined.scheme-full
    tidal-hifi
  ];
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  fonts.fonts = with pkgs; [
    vistafonts
    open-sans
    corefonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" ]; })
  ];
  services.ratbagd.enable = true;
}
