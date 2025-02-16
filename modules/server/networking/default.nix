{ config, pkgs, lib, ... }:

{
  imports = [
    ./avahi.nix
    ./caddy.nix
    ./dnsmasq.nix
    ./dyndns.nix
    ./unbound.nix
    # ./vpn.nix
    ./powerdns.nix
  ];
}
