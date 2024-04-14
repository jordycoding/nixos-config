{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.gitea)
{
  services.gitea = {
    enable = true;
    package = pkgs.unstable.gitea;
    lfs.enable = true;
  };
}
