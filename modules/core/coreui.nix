{ config, pkgs, inputs, lib, ... }:

lib.mkIf (config.var.enableUI)
{
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    onlyoffice-bin
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
    ghostty
    jellyfin-media-player
    inputs.zen-browser.packages."${system}".default
    gparted
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
    ibm-plex
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu
    nerd-fonts.symbols-only
  ];
  services.ratbagd.enable = true;
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        .zen-wrapped
      '';
      mode = "0755";
    };
  };
}
