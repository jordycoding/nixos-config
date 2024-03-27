{ config, outputs, pkgs, lib, ... }:

lib.mkIf (config.homelab.jellyfin)
{
  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "enp3s0";
    enableIPv6 = true;
  };

  networking.firewall.allowedTCPPorts = [ 8096 8920 ];
  networking.firewall.allowedUDPPorts = [ 1900 7359 ];

  containers.jellyfin = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";

    bindMounts = {
      "/series" = {
        hostPath = "/mnt/Media/Series";
      };
      "/movies" = {
        hostPath = "/mnt/Media/Movies";
      };
      "/anime" = {
        hostPath = "/mnt/Media/Anime";
      };
    };

    forwardPorts = [
      { protocol = "tcp"; hostPort = 8096; containerPort = 8096; }
      { protocol = "tcp"; hostPort = 8920; containerPort = 8920; }
      { protocol = "udp"; hostPort = 1900; containerPort = 1900; }
      { protocol = "udp"; hostPort = 7359; containerPort = 7459; }
    ];

    config = { config, pkgs, lib, ... }:
      let
        inherit outputs;
      in
      {
        nixpkgs = {
          overlays = [
            outputs.overlays.unstable-packages
          ];
        };

        services.jellyfin = {
          enable = true;
          package = pkgs.unstable.jellyfin;
          openFirewall = true;
        };

        system.stateVersion = "23.11";
        networking.useHostResolvConf = lib.mkForce false;

        services.resolved.enable = true;
      };

  };
}
