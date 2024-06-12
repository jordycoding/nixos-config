{ config, pkgs, lib, ... }:

lib.mkIf (config.homelab.ollama)
{
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    listenAddress = "0.0.0.0:11434";
  };

  virtualisation.oci-containers = {
    containers = {
      openwebui = {
        image = "ghcr.io/open-webui/open-webui:main";
        ports = [ "3030:8080" ];
        volumes = [
          "open-webui:/app/backend/data"
        ];
        extraOptions = [
          "--network=slirp4netns:allow_host_loopback=true"
          "--add-host=ollama.local:10.0.2.2"
        ];
        environment = {
          "OLLAMA_BASE_URL" = "http://ollama.local:11434";
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 3030 ];
}
