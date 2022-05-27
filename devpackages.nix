{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs
    python3
    vscode
    neovim
    git
  ];
}
