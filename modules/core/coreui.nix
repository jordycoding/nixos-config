{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    thunderbird
    protonmail-bridge
    protonvpn-gui
    piper
    tidal-hifi
    (firefox.override { nativeMessagingHosts = [ inputs.pipewire-screenaudio.packages.${pkgs.system}.default ]; })
    nicotine-plus
    qbittorrent
    discord
    webcord
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
