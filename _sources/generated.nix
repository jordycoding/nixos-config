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
    version = "ce2b892818cae9a5107e7b87e9cd7e46e3726bd0";
    src = fetchFromGitHub {
      owner = "jordycoding";
      repo = "neovim-lua";
      rev = "ce2b892818cae9a5107e7b87e9cd7e46e3726bd0";
      fetchSubmodules = false;
      sha256 = "sha256-rlSFV6jyV43OxS8wZRNirhZsxB2nGq9g2E3KP4IuBoE=";
    };
    date = "2025-03-16";
  };
  rpzblacklist = {
    pname = "rpzblacklist";
    version = "ffd6a7e6ef66e294e4d9229ace8ab3341973df45";
    src = fetchFromGitHub {
      owner = "hagezi";
      repo = "dns-blocklists";
      rev = "ffd6a7e6ef66e294e4d9229ace8ab3341973df45";
      fetchSubmodules = false;
      sha256 = "sha256-HPYpAw5d2vBjw4fgB8ykV3tjE7ZzZ1i4EElgLAaMbuE=";
    };
    date = "2025-03-16";
  };
}
