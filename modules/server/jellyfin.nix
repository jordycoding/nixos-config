{ config, outputs, pkgs, lib, ... }:

lib.mkIf (config.homelab.jellyfin)
{
  services.jellyfin = {
    enable = true;
    package = pkgs.jellyfin;
    openFirewall = true;
  };

  users.users.jellyfin = {
    extraGroups = [ "media" ];
  };

  nixpkgs.config.packageOverrides = prev: {
    jellyfin-ffmpeg = prev.jellyfin-ffmpeg.overrideAttrs (old: rec {
      configureFlags =
        # Remove deprecated Intel Media SDK support
        (builtins.filter (e: e != "--enable-libmfx") old.configureFlags)
        # Add Intel VPL support
        ++ [ "--enable-libvpl" ];
      buildInputs = old.buildInputs ++ [
        # VPL dispatcher
        pkgs.unstable.libvpl
      ];
    });
  };
}
