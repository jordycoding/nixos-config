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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.pulseaudio.enable = false;

  services.openssh.enable = true;

  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [
    { groups = [ "wheel" ]; keepEnv = true; persist = true; }
  ];
  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];

  # Needed for network printing
  # services.printing.listenAddresses = [ "*:631" ]; # Not 100% sure this is needed and you might want to restrict to the local network

  users.users.jordy = {
    isNormalUser = true;
    #Needed for podman rootless
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
    shell = pkgs.zsh;
  };
  # home-manager.users.jordy = import ./home.nix;

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  programs.virt-manager.enable = true;
}
