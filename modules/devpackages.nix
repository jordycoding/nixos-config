{ config, pkgs, lib, ... }:
with lib;

{
  options.languageservers = {
    enable = mkEnableOption "Enable language servers and related packages";
  };
  config = {
    programs.nix-ld.enable = true;
    programs.wireshark.enable = true;
    programs.adb.enable = true;
    environment.systemPackages = with pkgs; [
      ruby
      gnumake
      coursier
      circt
      verilog
      wireshark
      nodejs_latest
      corepack_latest
      python3
      python3Packages.pygments
      python3Packages.black
      vscode
      neovim
      git
      jetbrains.idea-ultimate
      jetbrains.datagrip
      jetbrains.dataspell
      jdk
      maven
      rustup
      gcc
      glade
      android-studio
      androidStudioPackages.canary
      dotnet-sdk_8
      php82
      php82Packages.composer
      pkg-config
      cachix
      bison
      gnum4
      go
      gotools
      elixir
      elixir-ls
      lazygit
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
        lldb
        clang
        clang-tools
        kotlin-language-server
        jdt-language-server
        nixd
        gopls
        ltex-ls
      ]
    );
  };
}
