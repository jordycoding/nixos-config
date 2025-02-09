{ config, inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
    gh
    neovim
    (pkgs.writeShellScriptBin "nvim-nightly" ''
      exec ${inputs.neovim-nightly-overlay.packages.${pkgs.system}.default}/bin/nvim "$@"
    '')
    rofi
    sway
    # thefuck
    alacritty
    mako
    swayidle
    swaylock
    grim
    slurp
    alacritty
    wlogout
    playerctl
    pulseaudio
    wl-clipboard
    zenity
    pavucontrol
    xdg-utils
    direnv
    papirus-folders
  ];
}
