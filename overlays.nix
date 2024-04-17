{ inputs, ... }: rec {
  jellyfin-ffmpeg-overlay = final: prev: {
    jellyfin-ffmpeg = prev.jellyfin-ffmpeg.override {
      ffmpeg_6-full = prev.ffmpeg_6-full.override {
        withMfx = false;
        withVpl = true;
      };
    };
  };
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs {
      overlays = [ jellyfin-ffmpeg-overlay ];
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
  samba = final: prev: {
    samba = prev.samba.override {
      enableMDNS = true;
    };
  };
}
