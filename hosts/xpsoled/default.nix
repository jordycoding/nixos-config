{ config, pkgs, lib, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
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
    ../../modules/wm/gnome.nix
    # ../../modules/wm/hyprland.nix
    # ../../modules/wm/kde.nix
    ../../modules/catppuccin-grub.nix
    ./hardware-configuration.nix
  ];

  virtualisation.docker.enableNvidia = true;
  nixpkgs.config.cudaSupport = true;

  # boot.plymouth = {
  #   enable = true;
  #   theme = "bgrt";
  # };
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
    # pkgs.epson-escpr2
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

  networking.hostName = "nixpsOLED";
  networking.networkmanager.enable = true;
  networking.wireguard.enable = true;
  hardware.bluetooth.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.sabnzbd.wantedBy = lib.mkForce [ ]; # Disable service by default, reduces boot time

  environment.systemPackages = with pkgs; [ nvidia-offload mesa-demos easyeffects ];
  services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.open = true;
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs ; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
