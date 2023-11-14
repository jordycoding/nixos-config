{ config, pkgs, ... }:

{
  imports = [
    ./dconf.nix
    ./gtk.nix
  ];
}
