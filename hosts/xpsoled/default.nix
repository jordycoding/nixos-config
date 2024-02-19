{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/system.nix
    ../../modules/devpackages.nix
    ../../modules/upgrade-diff.nix
    ../../modules/core
    ../../modules/usecases/gaming.nix
    ../../modules/usecases/school.nix
    ../../modules/usecases/hardening.nix
    ../../modules/usecases/downloading.nix
    ../../modules/catppuccin-grub.nix
    ./hardware-configuration.nix
    ../../modules/wm
  ];

  shell.gnome = true;

  virtualisation.docker.enableNvidia = true;
  # nixpkgs.config.cudaSupport = true;

  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.kernelParams = [ "quiet" "udev.log_level=0" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-intel" ];
  languageservers.enable = true;
  services.fwupd.enable = true;
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };
  services.printing.enable = true;
  services.printing.drivers = [
    # pkgs.epson-escpr
    pkgs.epson-escpr2
  ];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.printing.browsing = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;
  services.avahi.hostName = "alocal";
  services.avahi.ipv6 = true;

  home-manager.users.jordy.dotfiles.isLaptop = true;

  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.loader = {
    timeout = null;
    efi = {
      canTouchEfiVariables = true;
    };
    # grub = {
    #   efiSupport = true;
    #   device = "nodev";
    #   useOSProber = true;
    #   gfxmodeEfi = "1920x1080";
    # };
    grub = {
      enable = false;
    };
    systemd-boot = {
      enable = true;
    };
  };

  networking.hostName = "Krypton";
  networking.networkmanager.enable = true;
  networking.wireguard.enable = true;
  hardware.bluetooth.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.sabnzbd.wantedBy = lib.mkForce [ ]; # Disable service by default, reduces boot time

  environment.systemPackages = with pkgs; [ mesa-demos easyeffects ];

  services.xserver.videoDrivers = [ "nvidia" ];

  services.syncthing = {
    enable = true;
    user = "jordy";
    dataDir = "/home/jordy/syncthing";
    configDir = "/home/jordy/.config/syncthing";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    nvidiaSettings = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  services.switcherooControl.enable = true;
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs ; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Automatically disable fingerprint when external monitor desk connected
  services.udev.extraRules = ''
    ACTION=="add", ENV{PRODUCT}=="bda/2172/100", RUN+="${pkgs.bash}/bin/bash -c \"${pkgs.coreutils}/bin/ln -s /dev/null /run/systemd/transient/fprintd.service; ${pkgs.systemd}/bin/systemctl daemon-reload\""
    ACTION=="remove", ENV{PRODUCT}=="bda/2172/100", RUN+="${pkgs.bash}/bin/bash -c \"${pkgs.coreutils}/bin/rm -f /run/systemd/transient/fprintd.service; ${pkgs.systemd}/bin/systemctl daemon-reload\""
  '';
}
