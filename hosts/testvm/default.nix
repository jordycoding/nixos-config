{ inputs, ... }:
{
  imports = [
    ../../modules/system.nix
    ../../modules/core
    ../../modules/wm
    ./hardware-configuration.nix
  ];

  core.productivity = false;
  core.minimal = true;

  shell.gnome = true;
  home-manager.users.jordy.dotfiles.isLaptop = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "testvm"; # Define your hostname.

  services.xserver.videoDrivers = [ "qxl" ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
