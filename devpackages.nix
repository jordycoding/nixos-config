{ config, pkgs, lib, ... }:
with lib;

{
  options.languageservers = {
    enable = mkEnableOption "Enable language servers and related packages";
  };
  config = {
    environment.systemPackages = with pkgs; [
      nodejs_latest
      python3
      vscode
      neovim
      git
      jetbrains.idea-ultimate
      jdk
      maven
      rustup
      gcc
    ]
    ++ (
      optionals (config.languageservers.enable) [
        nixpkgs-fmt
        nil
        rust-analyzer
        checkstyle
        sumneko-lua-language-server
        google-java-format
      ]
    );
  };
}
