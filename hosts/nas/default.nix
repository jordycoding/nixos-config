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
    config.packageOverrides = prev: {
      jellyfin-ffmpeg = prev.jellyfin-ffmpeg.overrideAttrs (old: rec {
        configureFlags =
          # Remove deprecated Intel Media SDK support
          (builtins.filter (e: e != "--enable-libmfx") old.configureFlags)
          # Add Intel VPL support
          ++ [ "--enable-libvpl" ];
        buildInputs = old.buildInputs ++ [
          # VPL dispatcher
          pkgs.unstable.libvpl
        ];
      });
    };
  };

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
  ];

  environment.shellAliases = {
    update = "(cd /etc/nixos; doas nix flake update) && doas nixos-rebuild switch --upgrade --flake /etc/nixos";
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      (pkgs.callPackage ../../pkgs/onevpl-intel-gpu.nix { })
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

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

  users.users.jellyfin = {
    extraGroups = [ "media" ];
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
  boot.kernelParams = [ "i915.enable_guc=3" ];

  networking.hostName = "Tungsten";
  services.fstrim.enable = true;

  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  users.groups.media = { };
  users.groups.download = { };

  homelab.sonarr = true;
  homelab.radarr = true;
  homelab.prowlarr = true;
  homelab.recyclarr = true;
  homelab.sabnzbd = true;
  homelab.samba = true;
  homelab.jellyfin = true;

  systemd.tmpfiles.rules = [
    "d /mnt/Media/Series 0770 root media - -"
    "d /mnt/Media/Movies 0770 root media - -"
    "d /mnt/Media/Anime 0770 root media - -"
    "d /mnt/Ssd/Downloads/Sab 0770 root download - -"
    "d /mnt/Ssd/Downloads/Sab/incomplete 0770 root download - -"
    "d /mnt/Ssd/Downloads/Sab/complete 0770 root download - -"
  ];

  networking.hostId = "034146c2";
  system.stateVersion = "23.11";
}
