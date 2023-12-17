{ config, pkgs, ... }:

{
  imports = [
    ./coreapps.nix
    ./corecli.nix
    ./coreui.nix
  ];
  system.stateVersion = "23.11";
}
