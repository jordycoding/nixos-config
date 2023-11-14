{ pkgs, ... }:
{
  environment.systemPackages = with pkgs ; [
    steam
    lutris
  ];
}
