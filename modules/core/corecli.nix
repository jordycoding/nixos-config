{ pkgs, ... }:
{
  services.usbmuxd.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
    home-manager
    tmux
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
    qemu
    smartmontools
    ddcutil
    idevicerestore
    libimobiledevice
    pwgen
    ffmpeg
    tea
  ];
  services.udev.packages = with pkgs; [
    ddcutil
  ];
}
