{ config, osConfig, lib, ... }:

with lib;

{
  imports = (
    optionals (osConfig.shell.hypr) [
      ./hypr
      ./ags
    ]
  ) ++ (
    optionals (osConfig.shell.gnome) [
      ../gnome
    ]
    ++ (
      optionals (osConfig.shell.niri) [
        ./niri
      ]
    )
  );
}
