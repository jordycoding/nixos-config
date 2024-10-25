{ config, pkgs, lib, ... }:
with pkgs;
let
  vpnconfig = builtins.fromTOML (builtins.readFile ../../../config.toml);
in
{
  networking.firewall.allowedUDPPorts = [ 51820 ];
  systemd.network = {
    netdevs = vpnconfig.netdevs;
    networks = vpnconfig.networks;
  };
}
