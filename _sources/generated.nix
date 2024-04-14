# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alacrittycatppuccin = {
    pname = "alacrittycatppuccin";
    version = "94800165c13998b600a9da9d29c330de9f28618e";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "94800165c13998b600a9da9d29c330de9f28618e";
      fetchSubmodules = false;
      sha256 = "sha256-Pi1Hicv3wPALGgqurdTzXEzJNx7vVh+8B9tlqhRpR2Y=";
    };
    date = "2024-04-09";
  };
  dnsblacklist = {
    pname = "dnsblacklist";
    version = "2024.0414.0101.52";
    src = fetchurl {
      url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/dnsmasq/pro.plus.txt";
      sha256 = "sha256-bfSLTpC2s7HmNAKb9J/pUBLfSqq5D8xIU/nha5YuJNA=";
    };
  };
  dotfiles = {
    pname = "dotfiles";
    version = "74d70eba06c19bf8ae9c956c35cb108092cce86c";
    src = fetchFromGitHub {
      owner = "jordycoding";
      repo = "Dotfiles-Xps";
      rev = "74d70eba06c19bf8ae9c956c35cb108092cce86c";
      fetchSubmodules = false;
      sha256 = "sha256-4TUqSHTstDnTzu6PhFPWebnY8vWxhSM2tUNE4/xMUqo=";
    };
    date = "2024-03-09";
  };
  kittycatppuccin = {
    pname = "kittycatppuccin";
    version = "d7d61716a83cd135344cbb353af9d197c5d7cec1";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "kitty";
      rev = "d7d61716a83cd135344cbb353af9d197c5d7cec1";
      fetchSubmodules = false;
      sha256 = "sha256-mRFa+40fuJCUrR1o4zMi7AlgjRtFmii4fNsQyD8hIjM=";
    };
    date = "2024-01-10";
  };
  neovim = {
    pname = "neovim";
    version = "cf5e6c734e2b376399c58d9ef1df763c1276d9d2";
    src = fetchFromGitHub {
      owner = "jordycoding";
      repo = "neovim-lua";
      rev = "cf5e6c734e2b376399c58d9ef1df763c1276d9d2";
      fetchSubmodules = false;
      sha256 = "sha256-l8oRTg82hRK4QDe7yag/ScSdWJhHsdll8z0A0O+LIWA=";
    };
    date = "2024-04-12";
  };
}