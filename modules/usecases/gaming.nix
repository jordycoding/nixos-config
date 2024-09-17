{ pkgs, ... }:
{
  environment.systemPackages = with pkgs ; [
    steam
    lutris
    ryujinx
  ];
  hardware.xpadneo.enable = true;
}
