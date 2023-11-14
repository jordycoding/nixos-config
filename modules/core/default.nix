{ config, pkgs, ... }:

{
  imports = [
    ./coreapps.nix
    ./corecli.nix
    ./coreui.nix
  ];
}
