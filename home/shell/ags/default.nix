{ inputs, config, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.file.".config/ags" = {
    source = ./conf;
    recursive = true;
  };

  programs.ags = {
    enable = true;
    extraPackages = [ pkgs.libsoup_3 ];
  };
}
