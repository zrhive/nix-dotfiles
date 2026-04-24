{ inputs, ... }:
{
  # Unstable nixpkgs
  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # Custom built packages
  custom-packages =
    final: _:
    import ../packages {
      inherit inputs;
      pkgs = final;
    };
}
