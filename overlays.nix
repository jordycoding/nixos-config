{ inputs, ... }: rec {
  jellyfin-ffmpeg-overlay = final: prev: {
    jellyfin-ffmpeg = prev.jellyfin-ffmpeg.override {
      ffmpeg_7-full = prev.ffmpeg_7-full.override {
        withMfx = false;
        withVpl = true;
        withXevd = false;
        withXeve = false;
      };
    };
  };

  ffmpeg-vpl-overlay = final: prev: {
    ffmpeg = prev.ffmpeg.override {
      withVpl = true;
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
      # overlays = [ jellyfin-ffmpeg-overlay jellyfin-web-overlay ];
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "aspnetcore-runtime-6.0.36"
          "aspnetcore-runtime-wrapped-6.0.36"
          "dotnet-sdk-6.0.428"
          "dotnet-sdk-wrapped-6.0.428"
        ];
      };
    };
  };
  samba = final: prev: {
    samba = prev.samba.override {
      enableMDNS = true;
    };
  };
  sambaFull = final: prev: {
    samba4Full = prev.samba4Full.override {
      enableCephFS = false;
    };
  };
  kdematerialyou = final: prev: {
    kde-material-you-colors = prev.callPackage ./pkgs/kde-material-you/derivation.nix;
  };
  lldb_19-symlink = final: prev: {
    lldb = prev.lldb.overrideAttrs {
      dontCheckForBrokenSymlinks = true;
    };
  };

  fixups = final: prev: {
    libfprint = prev.libfprint.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [ prev.nss ];
    });
  };
}
