{ config, outputs, pkgs, lib, ... }:

{
  imports = [
    ../../modules/core/corecli.nix
    ../../modules/system.nix
    ../../modules/server
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];
  };

  users.users.jordy.extraGroups = [ "wheel" "libvirtd" "video" "media" "download" ];

  users.users.testuser = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  users.users.sonarr = {
    extraGroups = [ "media" "download" ];
  };

  users.users.radarr = {
    extraGroups = [ "media" "download" ];
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    mirroredBoots = [
      { devices = [ "nodev" ]; path = "/boot"; }
    ];
  };
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  networking.hostName = "Tungsten";
  services.fstrim.enable = true;

  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 8080 ];
  };

  users.groups.media = { };
  users.groups.download = { };

  homelab.sonarr = true;
  homelab.radarr = true;
  homelab.prowlarr = true;
  homelab.sabnzbd = true;
  homelab.samba = true;

  systemd.tmpfiles.rules = [
    "d /mnt/Media/Series 0770 root media - -"
    "d /mnt/Media/Movies 0770 root media - -"
    "d /mnt/Media/Anime 0770 root media - -"
    "d /mnt/Downloads/Sab 0770 root download - -"
  ];

  networking.hostId = "034146c2";
  system.stateVersion = "23.11";
}
