{ config, osConfig, lib, inputs, ... }:

{
  imports = [ inputs.niri.homeModules.niri ./binds.nix ./config.nix ./rules.nix ];

  config = { };
}
