{ config, pkgs, lib, ... }:
with lib;

{
  options.core = {
    productivity = mkOption {
      type = types.bool;
      default = true;
      description = mdDoc "Enable productivity tools";
    };
    minimal = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc "Enable minimal configuration";
    };
  };

  imports = [
    ./corecli.nix
    ./coreui.nix
    ./productivity.nix
  ];

  config = {
    system.stateVersion = "24.05";
  };
}
