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
  config = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    languageservers.enable = true;
    services.fwupd.enable = true;
    services.fprintd.enable = true;
    services.printing.enable = true;
    services.printing.drivers = [
      pkgs.epson-escpr
      pkgs.epson-escpr2
    ];
    services.avahi.enable = true;
    services.avahi.nssmdns = true;
    services.printing.browsing = true;
    services.avahi.publish.enable = true;
    services.avahi.publish.userServices = true;
    services.avahi.hostName = "alocal";
    services.avahi.ipv6 = true;

    systemd.services.fprintd = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.Type = "simple";
    };

    home-manager.users.jordy.dotfiles.isLaptop = true;
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
        gfxmodeEfi = "1920x1080";
      };
    };

    networking.hostName = "nixpsOLED";
    networking.networkmanager.enable = true;
    networking.wireguard.enable = true;
    hardware.bluetooth.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.services.sabnzbd.wantedBy = lib.mkForce [ ]; # Disable service by default, reduces boot time

    environment.systemPackages = with pkgs; [ nvidia-offload mesa-demos ];
    services.xserver.videoDrivers = [ "nvidia" ];
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
  };
}
