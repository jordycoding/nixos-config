{ config, pkgs, lib, ... }:
with lib;

{
  options.languageservers = {
    enable = mkEnableOption "Enable language servers and related packages";
  };
  config = {
    programs.wireshark.enable = true;
    programs.adb.enable = true;
    environment.systemPackages = with pkgs; [
      wireshark
      nodejs_latest
      python3
      python3Packages.pygments
      python3Packages.black
      vscode
      neovim
      git
      jetbrains.idea-ultimate
      jetbrains.datagrip
      jdk
      maven
      rustup
      gcc
      glade
      android-studio
      dotnet-sdk_7
      php82
      php82Packages.composer
      pkg-config
      cachix
    ]
    ++ (
      optionals (config.languageservers.enable) [
        nixpkgs-fmt
        nil
        rust-analyzer
        checkstyle
        sumneko-lua-language-server
        stylua
        google-java-format
        omnisharp-roslyn
        texlab
      ]
    );
  };
}
