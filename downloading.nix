{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fragments
  ];
  services.sabnzbd.enable = true;
}
