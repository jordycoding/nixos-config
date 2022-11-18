{ config, pkgs, lib, ... }:

let 
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  config = {
      languageservers.enable = true;
      home-manager.users.jordy.dotfiles.isLaptop = true;
	  boot.loader = {
	    efi = {
	      canTouchEfiVariables = true;
	    };
	    grub = {
	      efiSupport = true;
	      device = "nodev";
	      useOSProber = true;
          extraConfig = "set theme=(hd1,gpt2)/@nixos/${pkgs.catppuccinGrub}/grub/themes/catppuccin-mocha-grub-theme/theme.txt";
	    };
	  };

	  networking.hostName = "nixps";
	  networking.networkmanager.enable = true;
	  hardware.bluetooth.enable = true;
      systemd.services.NetworkManager-wait-online.enable = false;

	  environment.systemPackages = with pkgs; [ nvidia-offload mesa-demos ];
	  services.xserver.videoDrivers = [ "nvidia" ];
	  hardware.nvidia.prime = {
	    offload.enable = true;
	    intelBusId = "PCI:0:2:0";
	    nvidiaBusId = "PCI:1:0:0";
	  };
   };
}
