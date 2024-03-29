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
      bruno
      ruby
      gnumake
      coursier
      metals
      circt
      verilog
      wireshark
      nodejs_latest
      corepack_21
      python3
      python3Packages.pygments
      python3Packages.black
      efm-langserver
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
      androidStudioPackages.beta
      dotnet-sdk_8
      php82
      php82Packages.composer
      pkg-config
      cachix
      bison
      gnum4
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
      ]
    );
  };
}
