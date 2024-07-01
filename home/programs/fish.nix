{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    grc
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
      { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
    ];
  };
}

