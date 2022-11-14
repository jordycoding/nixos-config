# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos> 
      ./hardware-configuration.nix
      ./coreui.nix
      ./corecli.nix
      ./devpackages.nix
      ./gnome.nix
      ./gaming.nix
      ./machines/ryzenDesktop.nix
    ];

  nixpkgs.config.packageOverrides = super: {
    catppuccinGrub = pkgs.callPackage ./catppuccin-grub.nix {};
  };

  environment.systemPackages = [ pkgs.catppuccinGrub ];

  boot.supportedFilesystems = [ "ntfs" ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  security.rtkit.enable = true;
  security.pki.certificates = [ "-----BEGIN CERTIFICATE-----
MIICBzCCAaygAwIBAgIUXmj14sDxC/5atKG6ew4Zv4j+5dcwCgYIKoZIzj0EAwIw
ejELMAkGA1UEBhMCTkwxEjAQBgNVBAgMCUZyaWVzbGFuZDESMBAGA1UEBwwJSGFy
bGluZ2VuMQ8wDQYDVQQKDAZBbGtlbWExEjAQBgNVBAMMCWFsa2VtYS5jbzEeMBwG
CSqGSIb3DQEJARYPam9yZHlAYWxrZW1hLmNvMB4XDTIyMTAyMTEzNTAzNVoXDTIz
MTAyMTEzNTAzNVowejELMAkGA1UEBhMCTkwxEjAQBgNVBAgMCUZyaWVzbGFuZDES
MBAGA1UEBwwJSGFybGluZ2VuMQ8wDQYDVQQKDAZBbGtlbWExEjAQBgNVBAMMCWFs
a2VtYS5jbzEeMBwGCSqGSIb3DQEJARYPam9yZHlAYWxrZW1hLmNvMFkwEwYHKoZI
zj0CAQYIKoZIzj0DAQcDQgAEYTIN+uWbsUoT8Or8z6kdF44pVyq1u1WRuw+zRLV3
06rU6OvzuSY9HJ7sxm5p7tMuVKKVoFSNFET0rslEYBVwHaMQMA4wDAYDVR0TBAUw
AwEB/zAKBggqhkjOPQQDAgNJADBGAiEAnDaCpDb8fSIRgZO4EUhoyvLeiOlL4F3D
/ePfJArhn7oCIQDS6qX2U94OLyqamDWqD5c0KPIRUqIXUaDxqCs2mZdzkg==
-----END CERTIFICATE-----
"];
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.pulseaudio.enable = false;

  services.onedrive.enable = true;

  # Needed for steam
  hardware.opengl.driSupport32Bit = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [
    { groups = ["wheel"]; noPass = true; keepEnv = true; }
  ];
  
  users.users.jordy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
    #Needed for podman rootless
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
    shell = pkgs.zsh;
  };
  home-manager.users.jordy = import ./home.nix;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ pkgs.xdg-desktop-portal-wlr ];
  services.flatpak.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
      };
    };
    libvirtd.enable = true;
  };

  hardware.opengl.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

