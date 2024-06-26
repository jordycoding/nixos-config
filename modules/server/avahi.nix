{ config, pkgs, lib, ... }:
lib.mkIf (config.homelab.avahi)
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
    openFirewall = true;
  };
}
