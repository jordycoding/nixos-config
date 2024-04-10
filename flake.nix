{
  description = "Jordy's NixOS Flake";

  nixConfig =
    {
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
    };
  # This is the standard format for flake.nix.
  # `inputs` are the dependencies of the flake,
  # and `outputs` function will return all the build results of the flake.
  # Each item in `inputs` will be passed as a parameter to
  # the `outputs` function after being pulled and built.
  inputs = {
    # There are many ways to reference flake inputs.
    # The most widely used is `github:owner/name/reference`,
    # which represents the GitHub repository URL + branch/commit-id/tag.

    # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    nixguard.url = "github:jordycoding/nixguard";
    ags.url = "github:Aylur/ags";
    agenix.url = "github:ryantm/agenix";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
  };

  # `outputs` are all the build result of the flake.
  #
  # A flake can have many use cases and different types of outputs.
  # 
  # parameters in function `outputs` are defined in `inputs` and
  # can be referenced by their names. However, `self` is an exception,
  # this special parameter points to the `outputs` itself(self-reference)
  # 
  # The `@` syntax here is used to alias the attribute set of the
  # inputs's parameter, making it convenient to use inside the function.
  outputs = { self, nixpkgs, nixpkgs-stable, hyprland, agenix, lanzaboote, home-manager, pipewire-screenaudio, ... }@inputs:
    let
      inherit (self) outputs;
    in
    {
      overlays = import ./overlays.nix { inherit inputs; };
      nixosConfigurations = {
        # By default, NixOS will try to refer the nixosConfiguration with
        # its hostname, so the system named `nixos-test` will use this one.
        # However, the configuration name can also be specified using:
        #   sudo nixos-rebuild switch --flake /path/to/flakes/directory#<name>
        #
        # The `nixpkgs.lib.nixosSystem` function is used to build this
        # configuration, the following attribute set is its parameter.
        #
        # Run the following command in the flake's directory to
        # deploy this configuration on any NixOS system:
        #   sudo nixos-rebuild switch --flake .#nixos-test
        "Krypton" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit inputs; }; # this is the important part
          modules = [
            # Import the configuration.nix here, so that the
            # old configuration file can still take effect.
            # Note: configuration.nix itself is also a Nix Module,
            # Lanzaboote stuff(secure boot)
             lanzaboote.nixosModules.lanzaboote

             ./modules/core/lanzaboote.nix
            #-----------

            ./hosts/xpsoled
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                hyprland.homeManagerModules.default
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = { inherit inputs hyprland; }; # allows access to flake inputs in hm modules
              home-manager.useUserPackages = true;
              home-manager.users.jordy = import ./home;
            }
          ];
        };

        "Argon" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/ryzen_desktop
            home-manager.nixosModules.home-manager
            {
              # home-manager.sharedModules = [
              #   hyprland.homeManagerModules.default
              # ];
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = { inherit inputs hyprland; }; # allows access to flake inputs in hm modules
              home-manager.useUserPackages = true;
              home-manager.users.jordy = import ./home;
            }
          ];
        };

        "Tungsten" = nixpkgs-stable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/nas
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
            }
          ];
        };
      };
    };
}
