{ config, pkgs, lib, ... }:
with lib;

{
  options.homelab.incus = mkEnableOption "Enable Incus";
  config = mkIf (config.homelab.incus) {
    virtualisation.incus = {
      enable = true;
      ui.enable = true;
    };
    networking.firewall.allowedTCPPorts = [ 8443 ];
  };
}
