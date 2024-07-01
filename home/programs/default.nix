{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./fzf.nix
    ./git.nix
    ./zoxide.nix
    ./zsh.nix
    ./ssh.nix
    ./fish.nix
  ];
}
