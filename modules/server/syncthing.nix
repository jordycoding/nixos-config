{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.syncthing)
{
  users.users.syncthing = {
    extraGroups = [ "syncthing" ];
  };

  services.syncthing = {
    enable = true;
    package = pkgs.unstable.syncthing;
    user = "syncthing";
    group = "syncthing";
    dataDir = "/mnt/Ssd/Data/Syncthing";
    openDefaultPorts = true;
    guiAddress = "syncthing.alkema.co";
  };

  systemd.tmpfiles.rules = [
    "d /mnt/Ssd/Data/Syncthing 0770 syncthing syncthing - -"
  ];
}
