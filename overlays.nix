{ inputs, ... }: {
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
}
