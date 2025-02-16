{ config, pkgs, lib, ... }:
with lib;

{
  options.var = {
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
