{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    libreoffice-fresh
    thunderbird
    piper
    # texlive.combined.scheme-full
    tidal-hifi
    firefox-bin
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
