{ pkgs, config, lib, ... }:
with lib;

{
  environment.systemPackages = with pkgs; [
    docker-compose
    home-manager
    tmux
    neofetch
    pfetch
    bat
    wget
    # httpie
    eza
    broot
    bind
    pv
    exfat
    pciutils
    lm_sensors
    btop
    fio
    nurl
    openssl
    ripgrep
    efibootmgr
    # openai-whisper
    parted
  ] ++ (
    optionals (!config.core.minimal) [
      multipath-tools
      ollama
      libimobiledevice
      hyperfine
    ]
  );
}
