# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alacrittycatppuccin = {
    pname = "alacrittycatppuccin";
    version = "f6cb5a5c2b404cdaceaff193b9c52317f62c62f7";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "f6cb5a5c2b404cdaceaff193b9c52317f62c62f7";
      fetchSubmodules = false;
      sha256 = "sha256-H8bouVCS46h0DgQ+oYY8JitahQDj0V9p2cOoD4cQX+Q=";
    };
    date = "2024-10-28";
  };
  dnsblacklist = {
    pname = "dnsblacklist";
    version = "2024.0417.0102.50";
    src = fetchurl {
      url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/7c587c2/dnsmasq/pro.plus.txt";
      sha256 = "sha256-URg0ye2IUzq8dLgJiHRG6rCvDvtBZPQ5VuNK1OPsSgY=";
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
    version = "b14e8385c827f2d41660b71c7fec1e92bdcf2676";
    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "kitty";
      rev = "b14e8385c827f2d41660b71c7fec1e92bdcf2676";
      fetchSubmodules = false;
      sha256 = "sha256-59ON7CzVgfZUo7F81qQZQ1r6kpcjR3OPvTl99gzDP8E=";
    };
    date = "2024-11-10";
  };
  neovim = {
    pname = "neovim";
    version = "4ddd6f52dae011e1aef417384f760bbe74c3fdaf";
    src = fetchFromGitHub {
      owner = "jordycoding";
      repo = "neovim-lua";
      rev = "4ddd6f52dae011e1aef417384f760bbe74c3fdaf";
      fetchSubmodules = false;
      sha256 = "sha256-IRtLdfvwc0qi5pHRARFtDU/f9HZcIKhHOWiViWZaffE=";
    };
    date = "2025-01-27";
  };
  unboundblacklist = {
    pname = "unboundblacklist";
    version = "2024.1207.1408.09";
    src = fetchurl {
      url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/689f848/rpz/pro.plus.txt";
      sha256 = "sha256-BPa0pDteSzxcR5MrPobQho1nRFX81iG+7NMFDy7bEPo=";
    };
  };
}
