{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ryzenix"; # Define your hostname.
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.interfaces.enp34s0.wakeOnLan.enable = true;
  networking.networkmanager.insertNameservers = [ "192.168.1.21" ];
}