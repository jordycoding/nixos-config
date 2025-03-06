{ config, pkgs, lib, ... }:
with lib;

{
  options.homelab.incus = mkEnableOption "Enable Incus";
  config = mkIf (config.homelab.incus) {
    virtualisation.incus = {
      enable = true;
      ui.enable = true;
      package = pkgs.unstable.incus;
    };
    networking.firewall.allowedTCPPorts = [ 8443 ];
    # Incus needs this for some reason
    networking.nftables.enable = true;
  };
}
