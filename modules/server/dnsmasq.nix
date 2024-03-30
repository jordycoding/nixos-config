{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.dnsmasq)
{
  services.dnsmasq = {
    enable = true;
    package = pkgs.unstable.dnsmasq;
    settings = {
      listen-address = [ "::1" "127.0.0.1" "192.168.1.74" ];
      interface = "enp3s0";
      domain = "tungsten.lan";
      server = [ "9.9.9.9" "149.112.112.112" ];
      address = [ "/tungsten.home.lab/192.168.1.74" ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
