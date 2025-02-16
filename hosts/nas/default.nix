{ config, inputs, outputs, pkgs, lib, ... }:

let
  zfsCompatibleKernelPackages = lib.filterAttrs
    (
      name: kernelPackages:
        (builtins.match "linux_[0-9]+_[0-9]+" name) != null
        && (builtins.tryEval kernelPackages).success
        && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken)
    )
    pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in
lib.warn "ASP.NET Core 6 is EOL, remove when *arr doesn't depend on it anymore"
{
  imports = [
    ../../modules/core
    ../../modules/upgrade-diff.nix
    ../../modules/system.nix
    ../../modules/server
    ./hardware-configuration.nix
  ];

  options.services.unbound.settings.server.local-data = lib.mkOption {
    type = lib.types.anything;
  };

  config = {
    age.secrets.wgPrivkey = {
      file = ../../secrets/wgPrivkey.age;
      mode = "770";
      owner = "systemd-network";
      group = "systemd-network";
    };
    age.secrets.ddPassword = {
      file = ../../secrets/ddPassword.age;
    };
    age.secrets.keycloakDbPassword = {
      file = ../../secrets/keycloakDbPassword.age;
      owner = "keycloak";
      group = "keycloak";
    };
    age.secrets.immichEnv = {
      file = ../../secrets/immichEnv.age;
    };
    age.secrets.pgEnv = {
      file = ../../secrets/pgEnv.age;
    };

    networking.useNetworkd = true;
    systemd.network.enable = true;
    services.openssh.settings.PasswordAuthentication = false;
    users.users.jordy = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4s3aJHRoD5U8cTu1+NrvA1LTSDpAOqcTTF0p2L6UGF"
      ];
    };

    services.resolved = {
      extraConfig = ''
        DNSStubListener=no
      '';
    };
    services.zfs.autoScrub.enable = true;

    system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "--update-input"
        "nixpkgs-stable"
        "--print-build-logs"
      ];
      dates = "04:30";
      allowReboot = true;
    };

    nixpkgs = {
      overlays = [
        outputs.overlays.unstable-packages
        outputs.overlays.samba
        outputs.overlays.ffmpeg-vpl-overlay
      ];
    };

    environment.systemPackages = with pkgs; [
      intel-gpu-tools
      inputs.nixguard.packages.x86_64-linux.default
      wireguard-tools
      ghostty
    ];

    environment.shellAliases = {
      update = "(cd /etc/nixos; doas nix flake update) && doas nixos-rebuild switch --upgrade --flake /etc/nixos";
    };

    hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
        vpl-gpu-rt
      ];
    };
    environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

    users.users.jordy.extraGroups = [ "wheel" "libvirtd" "video" "media" "download" "render" ];

    users.users.testuser = {
      isNormalUser = true;
      shell = pkgs.zsh;
    };

    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.timeout = 0;
    boot.loader.grub = {
      enable = true;
      zfsSupport = true;
      efiSupport = true;
      mirroredBoots = [
        { devices = [ "nodev" ]; path = "/boot"; }
      ];
    };
    boot.kernelPackages = latestKernelPackage;
    boot.kernelParams = [ "i915.enable_guc=3" ];

    networking.hostName = "Tungsten";
    services.fstrim.enable = true;

    networking.firewall = {
      enable = true;
      allowPing = true;
    };

    users.groups.media = { };
    users.groups.download = { };

    homelab.sonarr = true;
    homelab.radarr = true;
    homelab.prowlarr = true;
    homelab.recyclarr = true;
    homelab.sabnzbd = true;
    homelab.samba = true;
    homelab.plex = true;
    homelab.caddy = true;
    homelab.bazarr = true;
    homelab.avahi = true;
    homelab.dyndns = true;
    homelab.gitea = true;
    homelab.syncthing = true;
    homelab.jellyfin = true;
    homelab.openrgb = true;
    homelab.powerdns.enable = true;
    # homelab.ollama = true;
    homelab.keycloak = true;
    homelab.ldap = true;
    homelab.miniflux = true;
    homelab.immich = {
      enable = true;
      immichEnvFile = "/run/agenix/immichEnv";
      pgEnvFile = "/run/agenix/pgEnv";
    };
    homelab.pixiecore = true;
    # homelab.dnsmasq = {
    #   enable = true;
    #   blacklist = true;
    # };
    homelab.matrix = {
      enable = true;
      createDb = true;
      dbPasswordFile = "/run/agenix/matrixDbPass";
    };
    homelab.calibre = true;
    homelab.grafana = true;
    homelab.unmanic = true;
    homelab.titleCardMaker = true;

    var.enableUI = false;

    systemd.tmpfiles.rules = [
      "d /mnt/Media/Series 0770 root media - -"
      "d /mnt/Media/Movies 0770 root media - -"
      "d /mnt/Media/Anime 0770 root media - -"
      "d /mnt/Ssd/Downloads/Sab 0770 root download - -"
      "d /mnt/Ssd/Downloads/Sab/incomplete 0770 root download - -"
      "d /mnt/Ssd/Downloads/Sab/complete 0770 root download - -"
    ];
    services.fail2ban.enable = true;

    networking.hostId = "034146c2";
    system.stateVersion = "23.11";
  };
}
