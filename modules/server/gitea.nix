{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.gitea)
{
  users.users.gitea = {
    isSystemUser = true;
    extraGroups = [ "gitea" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICnFFBdoooh1hC/NKPBaT78iLQ280JC4mn7QmJmsZMi8"
    ];
  };
  services.gitea = {
    enable = true;
    package = pkgs.unstable.gitea;
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "gitea.alkema.co";
        ROOT_URL = "https://gitea.alkema.co";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
    };
  };
}
