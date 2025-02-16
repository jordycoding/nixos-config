{ config, inputs, lib, pkgs, outputs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/netboot/netboot-base.nix")
    ../../modules/wm
    ../../modules/devpackages.nix
  ];
  config = {
    services.openssh = {
      enable = true;
      openFirewall = true;

      settings = {
        PasswordAuthentication = false;
      };
    };
    users.users.nixos.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4s3aJHRoD5U8cTu1+NrvA1LTSDpAOqcTTF0p2L6UGF"
    ];

    services.xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };

    services.displayManager.autoLogin = {
      enable = true;
      user = "nixos";
    };

    networking.networkmanager.enable = true;
    networking.wireless.enable = lib.mkImageMediaOverride false;

    environment.defaultPackages = with pkgs; [
      firefox
      gparted
      ghostty
    ];

    programs.git.enable = true;

    var.dev = {
      tools = true;
      nix = true;
    };

    systemd.tmpfiles.rules = [
      "f /home/nixos/.config/gnome-initial-setup-done 0711 nixos - - yes"
    ];
  };
}
