{ pkgs, ... }:
{
  environment.systemPackages = with pkgs ; [
    steam
    lutris
    ryubing
  ];
  hardware.xpadneo.enable = true;
}
