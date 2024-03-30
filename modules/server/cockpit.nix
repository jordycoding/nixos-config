{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.cockpit) {
  services.cockpit = {
    enable = true;
    package = pkgs.unstable.cockpit;
    openFirewall = true;
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };
}
