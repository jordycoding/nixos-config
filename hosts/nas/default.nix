{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/core/corecli.nix
    ../../modules/system.nix
    ../../modules/server
  ];

  users.users.jordy.extraGroups = [ "wheel" "libvirtd" "video" "media" "download" ];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  networking.hostName = "Tungsten";
  services.fstrim.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  users.groups.media = { };
  users.groups.download = { };

  homelab.sonarr = true;
  homelab.radarr = true;
  homelab.sabnzbd = true;
  homelab.samba = true;

  systemd.tmpfiles.rules = [
    "d /mnt/Multimedia/TV\ Shows 0760 root media - -"
    "d /mnt/Multimedia/Movies 0760 root media - -"
    "d /mnt/Multimedia/Anime 0760 root media - -"
    "d /mnt/Downloads/Sab 0760 root download - -"
  ];
}
