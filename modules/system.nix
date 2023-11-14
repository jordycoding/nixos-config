{ config, pkgs, ... }:

{
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  boot.supportedFilesystems = [ "ntfs" ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "Europe/Amsterdam";

  security.rtkit.enable = true;
  security.pki.certificates = [
    "-----BEGIN CERTIFICATE-----
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
"
  ];

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

  services.openssh.enable = true;

  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [
    { groups = [ "wheel" ]; keepEnv = true; persist = true; }
  ];

  # Needed for network printing
  # services.printing.listenAddresses = [ "*:631" ]; # Not 100% sure this is needed and you might want to restrict to the local network
  programs.zsh.enable = true;

  users.users.jordy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "input" "wireshark" ];
    #Needed for podman rootless
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
    shell = pkgs.zsh;
  };
  # home-manager.users.jordy = import ./home.nix;
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
}
