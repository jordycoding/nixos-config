{ pkgs, ... }:
{
  environment.systemPackages = with pkgs ; [
    steam
    lutris
    ryubing
    bottles
  ];
  hardware.xpadneo.enable = true;
  # For btrfs file sharing
  users.groups.gaming.gid = 1001;
  users.users.jordy.extraGroups = [ "gaming" ];
}
