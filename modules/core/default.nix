{ config, pkgs, lib, ... }:
with lib;

{
  options.core = {
    enableUI = mkEnableOption "Enable UI Packages";
  };
  imports = [
    ./corecli.nix
    ./coreui.nix
  ];
  config = {
    system.stateVersion = "23.11";
  };
}
