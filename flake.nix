{
  description = "zhyie's Nix Flake Configuration";

  inputs = {
    self.submodules = true;
    ## NIXPKGS --------------------------------------------------
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    ## HARDWARE MODULES -----------------------------------------
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    ## HOME MANAGER ---------------------------------------------
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ## DEVELOPMENT ----------------------------------------------
    direnv-instant.url = "github:Mic92/direnv-instant";
    direnv-instant.inputs.nixpkgs.follows = "nixpkgs";
    ## SECRET MANAGEMENT ----------------------------------------
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    ## THEMES ---------------------------------------------------
    catppuccin.url = "github:catppuccin/nix/release-25.11";
    ## PERSONAL REPO --------------------------------------------
    suckless.url = "path:/home/zhyie/.suckless";
    suckless.flake = false;
    dotfiles.url = "path:./dotfiles";
    dotfiles.flake = false;
    secrets.url = "path:./.secrets";
    secrets.flake = false;
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      ## Hosts and their specifications
      hosts = import ./hosts;
      users = import ./users;
      ## Set of args to pass in
      args = { inherit inputs hosts users; };

      lib = import ./lib args;
      inherit (lib) mkHost;
      inherit (nixpkgs.lib)
        mapAttrs
        genAttrs
        # listToAttrs
        attrValues
        unique
        # systems
        ;
      # systems = systems.flakeExposed;

      ## Get the systems within hosts attrs, lib.unique to prevent duplicates
      systems = unique (attrValues (mapAttrs (_: h: h.system) hosts));
      eachSystem = f: genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      ## GENERATE HOSTS|HOMES CONFIGURATION
      nixosConfigurations = mapAttrs mkHost hosts;
      # darwinConfigurations = mapAttrs mkHost hosts;
      # homeConfigurations = listToAttrs (mkHome hosts);

      ## EXPORT MODULES
      nixosModules = import ./modules/nixos;
      homeModules = import ./modules/home;

      overlays = import ./overlays { inherit inputs; };
      formatter = eachSystem (pkgs: pkgs.alejandra);
      packages = eachSystem (pkgs: import ./packages { inherit pkgs inputs; });
      devShells = eachSystem (pkgs: import ./shell.nix { inherit pkgs; });
    };
}
