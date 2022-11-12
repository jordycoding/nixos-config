{ config, pkgs, ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };

  networking.hostName = "nixps";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
}
