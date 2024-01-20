{ pkgs, config, lib, ... }:

lib.mkIf (config.core.productivity)
{
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    texlive.combined.scheme-full
  ];
}
