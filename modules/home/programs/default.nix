{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./fzf.nix
    ./git.nix
    ./zsh.nix
  ];
}
