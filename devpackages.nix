{ pkgs, ... }:
{
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
    rust-analyzer
    nil
  ];
}
