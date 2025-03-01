{ config, outputs, pkgs, lib, ... }:

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
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.kernelModules = [ "amdgpu" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Argon"; # Define your hostname.
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.interfaces.enp34s0.wakeOnLan.enable = true;
  # networking.networkmanager.insertNameservers = [ "192.168.1.21" ];

  virtualisation.incus.enable = true;
  networking.nftables.enable = true;

  hardware.pulseaudio.enable = false;
  hardware.i2c.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.rate" = 384000;
          default.clock.allowed-rates = [ 44100 48000 96000 192000 384000 ];
        };
      };
    };
  };

  services.syncthing = {
    enable = true;
    user = "jordy";
    dataDir = "/home/jordy/syncthing";
    configDir = "/home/jordy/.config/syncthing";
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  hardware.graphics = {
    enable32Bit = true;
    enable = true;
    extraPackages = with pkgs; [ libvdpau-va-gl ];
  };

  environment.systemPackages = with pkgs; [
    clinfo
    wineWowPackages.stable
    vscode
  ];

  systemd.tmpfiles.rules = [
    "d /mnt/games 0770 root gaming - -"
    "d /mnt/games_sata 0770 root gaming - -"
  ];

  var = {
    enableUI = true;
    dev = {
      node = true;
      python = true;
      tools = true;
      jetbrains = true;
      java = true;
      android = true;
      dotnet = true;
      php = true;
      go = true;
      nix = true;
      latex = true;
      lua = true;
      rust = true;
    };
  };
  services.fstrim.enable = true;
}
