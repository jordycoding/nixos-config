{ config, pkgs, lib, ... }:

{
  imports = [
    ./sonarr.nix
    ./radarr.nix
    ./prowlarr.nix
    ./recyclarr.nix
    ./bazarr.nix
  ];
}
