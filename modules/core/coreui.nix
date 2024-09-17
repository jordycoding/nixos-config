{ config, pkgs, inputs, lib, ... }:

lib.mkIf (config.core.enableUI)
{
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    protonmail-bridge
    protonvpn-gui
    piper
    texlive.combined.scheme-full
    tidal-hifi
    (firefox.override { nativeMessagingHosts = [ inputs.pipewire-screenaudio.packages.${pkgs.system}.default ]; })
    nicotine-plus
    qbittorrent
    swayosd
    discord
    webcord
    alacritty
    kitty
    obsidian
    element-desktop
    # cinny-desktop
    librewolf
    deepfilternet
    easyeffects
  ];
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "jordy" ];
  };
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
