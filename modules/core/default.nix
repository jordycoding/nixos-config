{ config, pkgs, ... }:

{
  imports = [
    ./corecli.nix
    ./coreui.nix
  ];
  system.stateVersion = "23.11";
}
