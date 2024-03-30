{ config, pkgs, lib, ... }:
with pkgs;

lib.mkIf (config.homelab.plex)
{
  services.plex = {
    enable = true;
    package = pkgs.unstable.plex;
    group = "media";
    openFirewall = true;
    extraScanners = [
      (fetchFromGitHub {
        owner = "ZeroQI";
        repo = "Absolute-Series-Scanner";
        rev = "22efb3dd849b17685c0fc80c60af7e515fa0d168";
        sha256 = "1hmxrqqpmzlcppcy5v1jqsizkhkfdd26i4wk1hkycgqssgmn35j6";
      })
    ];
    extraPlugins = [
      (builtins.path {
        name = "Hama.bundle";
        path = pkgs.fetchFromGitHub {
          owner = "ZeroQI";
          repo = "Hama.bundle";
          rev = "bb684a2299d06b1377b4d3e1c81dff417ce4e9de";
          sha256 = "05pwq1086nsybgsxi47cva1haaqdndfs7kqklb93v855d0ivrm9y";
        };
      })
    ];
  };
}
