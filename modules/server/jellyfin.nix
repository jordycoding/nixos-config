{ config, outputs, pkgs, lib, ... }:

lib.mkIf (config.homelab.jellyfin)
{
  services.jellyfin = {
    enable = true;
    package = pkgs.unstable.jellyfin;
    openFirewall = true;
  };
  environment.variables = {
    NEOReadDebugKeys = "1";
    OverrideGpuAddressSpace = "48";
  };

  systemd.services."jellyfin".environment = {
    NEOReadDebugKeys = "1";
    OverrideGpuAddressSpace = "48";
  };

  users.users.jellyfin = {
    extraGroups = [ "media" ];
  };

  hardware.opengl.extraPackages = with pkgs; [
    unstable.vpl-gpu-rt
  ];
}
