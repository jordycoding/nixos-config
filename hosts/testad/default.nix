{ config, outputs, pkgs, lib, ... }:

{
  imports = [
    ../../modules/system.nix
    ../../modules/core
    ./hardware-configuration.nix
    ../../modules/wm
  ];

  shell.gnome = true;
  var = {
    enableUI = true;
    adClient = true;
  };
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub.enable = false;
    systemd-boot.enable = true;
  };
  networking.hostName = "nixad";
  networking.networkmanager.enable = true;
}
