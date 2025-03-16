{ config, pkgs, lib, ... }:
with lib;

let dev = config.var.dev;
in
{
  options.var.dev = {
    node = mkEnableOption "NodeJS Development";
    python = mkEnableOption "Pyton Development";
    tools = mkEnableOption "Basic Development tools";
    jetbrains = mkEnableOption "Jetbrains IDEs";
    java = mkEnableOption "Java Development";
    android = mkEnableOption "Android Development";
    dotnet = mkEnableOption "Dotnet Development";
    php = mkEnableOption "PHP Development";
    go = mkEnableOption "Go Development";
    elixir = mkEnableOption "Elixir Development";
    c = mkEnableOption "C Development";
    nix = mkEnableOption "Nix Development";
    latex = mkEnableOption "Latex Support";
    lua = mkEnableOption "Lua Development";
    rust = mkEnableOption "Rust Development";
  };
  config = mkMerge [
    (mkIf dev.node {
      environment.systemPackages = with pkgs; [
        nodejs_latest
        corepack_latest
        bun
      ];
    })

    (mkIf dev.python {
      environment.systemPackages = with pkgs; [
        python3Packages.black
      ];
    })

    (mkIf dev.tools {
      environment.systemPackages = with pkgs; [
        neovim
        lazygit
        clang
        luajitPackages.luarocks
      ];
    })

    (mkIf dev.jetbrains {
      environment.systemPackages = with pkgs; [
        jetbrains.idea-ultimate
        jetbrains.datagrip
        jetbrains.dataspell
      ];
    })

    (mkIf dev.java {
      environment.systemPackages = with pkgs; [
        jdk
        maven
        google-java-format
        kotlin-language-server
        jdt-language-server
        checkstyle
      ];
    })

    (mkIf dev.android {
      programs.adb.enable = true;
      environment.systemPackages = with pkgs; [
        android-studio
        androidStudioPackages.canary
      ];
    })

    (mkIf dev.dotnet {
      environment.systemPackages = with pkgs; [
        dotnet-sdk_8
        omnisharp-roslyn
      ];
    })

    (mkIf dev.php {
      environment.systemPackages = with pkgs; [
        php82
        php82Packages.composer
      ];
    })

    (mkIf dev.go {
      environment.systemPackages = with pkgs; [
        go
        gotools
        gopls
      ];
    })

    (mkIf dev.elixir {
      environment.systemPackages = with pkgs; [
        elixir
        elixir-ls
      ];
    })

    (mkIf dev.c {
      environment.systemPackages = with pkgs; [
        clang
        clang-tools
        gcc
      ];
    })

    (mkIf dev.nix {
      environment.systemPackages = with pkgs; [
        cachix
        nixd
        nixpkgs-fmt
        nil
      ];
    })

    (mkIf dev.latex {
      environment.systemPackages = with pkgs; [
        texlab
        ltex-ls
      ];
    })

    (mkIf dev.lua {
      environment.systemPackages = with pkgs; [
        sumneko-lua-language-server
        stylua
      ];
    })

    (mkIf dev.rust {
      environment.systemPackages = with pkgs; [
        rust-analyzer
        rustup
      ];
    })

    {
      programs.nix-ld.enable = true;
      programs.wireshark.enable = true;

      environment.systemPackages = with pkgs; [
        ruby
        gnumake
        wireshark
        python3
        python3Packages.pygments
        git
        pkg-config
        bison
        gnum4
      ];
    }
  ];
}
