{ config, pkgs, lib, ... }:

{
  imports = [
    # ./gtk.nix
    ./dconf.nix
  ];
}
