{ inputs, config, pkgs, lib, ... }:

with lib;

{
  imports = [
    ./dotfiles
    ./programs
    # ./gnome
    ./shell/hypr
    ./shell/ags
  ];

  options.dotfiles = {
    isLaptop = mkEnableOption "Use laptop dotfiles";
  };

  config = {
    home = {
      username = "jordy";
      homeDirectory = "/home/jordy";
      stateVersion = "23.05";
      sessionVariables.NIXOS_OZONE_WL = "1";
    };

    programs.home-manager.enable = true;
  };
}
