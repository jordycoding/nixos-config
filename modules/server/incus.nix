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
    services.openssh.settings.X11Forwarding = true;
    networking.useDHCP = false;
    networking.bridges = {
      br0 = {
        interfaces = [ "enp3s0" ];
      };
    };
    networking.interfaces."br0".ipv4.addresses = [
      {
        address = "192.168.1.74";
        prefixLength = 24;
      }
    ];
    networking.defaultGateway = {
      address = "192.168.1.1";
      interface = "br0";
    };
    # systemd.network = {
    #   netdevs = {
    #     "20-vlan10" = {
    #       netdevConfig = { Kind = "vlan"; Name = "vlan10"; };
    #       vlanConfig.Id = 10;
    #     };
    #   };
    #   networks = {
    #     "30-enp3s0" = {
    #       matchConfig = { Name = "enp3s0"; };
    #       networkConfig = { DHCP = "yes"; MACVLAN = [ "vlan10" ]; };
    #     };
    #     "40-vlan10" = {
    #       matchConfig = { Name = "vlan10"; };
    #       networkConfig = {
    #         Address = "192.168.1.26";
    #         Gateway = "192.168.1.1";
    #         DNS = "1.1.1.1";
    #       };
    #     };
    #   };
    # };
  };
}
