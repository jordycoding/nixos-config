{ inputs, ... }: rec {
  jellyfin-ffmpeg-overlay = final: prev: {
    jellyfin-ffmpeg = prev.jellyfin-ffmpeg.override {
      ffmpeg_6-full = prev.ffmpeg_6-full.override {
        withMfx = false;
        withVpl = true;
      };
    };
  };
  jellyfin-web-overlay = final: prev: {
    jellyfin-web = prev.jellyfin-web.overrideAttrs {
      postInstall = ''
        sed -i -e "s+</head>+<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>+" $out/share/jellyfin-web/index.html
      '';
    };
  };
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs {
      overlays = [ jellyfin-ffmpeg-overlay jellyfin-web-overlay ];
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
  samba = final: prev: {
    samba = prev.samba.override {
      enableMDNS = true;
    };
  };
  kdematerialyou = final: prev: {
    kde-material-you-colors = prev.callPackage ./pkgs/kde-material-you/derivation.nix;
  };
}
