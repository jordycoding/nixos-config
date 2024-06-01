{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/system.nix
    ../../modules/devpackages.nix
    ../../modules/upgrade-diff.nix
    ../../modules/core
    ../../modules/usecases/gaming.nix
    ../../modules/usecases/downloading.nix
    ../../modules/wm
    ./hardware-configuration.nix
  ];

  users.users.jordy.extraGroups = [ "wheel" "libvirtd" "input" "wireshark" "video" "kvm" ];

  shell.gnome = true;
  services.flatpak.enable = true;

  languageservers.enable = true;
  home-manager.users.jordy.dotfiles.isLaptop = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.kernelModules = [ "amdgpu" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Argon"; # Define your hostname.
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.interfaces.enp34s0.wakeOnLan.enable = true;
  # networking.networkmanager.insertNameservers = [ "192.168.1.21" ];

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  core.enableUI = true;
  services.fstrim.enable = true;
}
