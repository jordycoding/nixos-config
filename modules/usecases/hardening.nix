{ pkgs, ... }:
{
    programs.firejail = {
    enable = true;
    wrappedBinaries = {
        zoom = {
        executable = "${pkgs.zoom-us}/bin/zoom";
        profile = "${pkgs.firejail}/etc/firejail/zoom.profile";
        extraArgs = [
         "--private"
        ];
        };
        zoom-us = {
        executable = "${pkgs.zoom-us}/bin/zoom-us";
        profile = "${pkgs.firejail}/etc/firejail/zoom.profile";
        extraArgs = [
         "--private"
        ];
        };
    };
    };
}
