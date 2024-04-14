{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.gitea)
{
  services.gitea = {
    enable = true;
    package = pkgs.unstable.gitea;
    lfs.enable = true;
    settings.server = {
      SSH_PORT = 2222;
      DOMAIN = "gitea.alkema.co";
    };
  };
}
