{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sabnzbd
    fragments
  ];
}
