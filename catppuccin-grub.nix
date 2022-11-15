{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "Catppuccin Grub theme";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "grub";
    rev = "81e6894";
    sha256 = "1n9j8xswg5ljap9gpb8phgwwmr4lzxq27cy4hnrvf4m9maxqg7m2";
  };

  installPhase =
    ''
      mkdir -p "$out/grub/themes"
      mv src/* "$out/grub/themes"
    '';

  meta = with lib; {
    description = "Catppuccin theme for Grub";
  };
}
