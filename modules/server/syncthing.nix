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
    dataDir = "/mnt/Vault/Data/Syncthing";
    openDefaultPorts = true;
  };

  systemd.tmpfiles.rules = [
    "d /mnt/Vault/Data/Syncthing 0770 syncthing syncthing - -"
  ];
}
