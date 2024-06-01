{ pkgs, ... }:
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
    hyperfine
    fio
    nurl
    openssl
    ripgrep
    libimobiledevice
    efibootmgr
    ollama
    parted
    multipath-tools
    ncdu
    nvfetcher
<<<<<<< Updated upstream
    qemu
=======
    smartmontools
>>>>>>> Stashed changes
  ];
}
