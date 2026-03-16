{
  description = "zhyie's Nix Flake Configuration";

  inputs = {
    # NIX PACKAGES FOR NIXOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # MODULES FOR HARDWARE QUIRKS
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # HOME MANAGER FOR NIX
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # SECRET MANAGEMENT
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # CATPUCCIN THEMES
    catppuccin.url = "github:catppuccin/nix/release-25.11";

    # PERSONAL REPO
    suckless = { url = "path:/home/zhyie/.suckless"; flake = false; };
    dotfiles = { url = "path:./dotfiles"; flake = false; };
    # dotfiles = { url = "git+file://./dotfiles"; flake = false; };
    secrets = { url = "path:./.secrets"; flake = false; };
    self.submodules = true;
  };

  outputs = { self, nixpkgs, ... } @ inputs: let
    inherit (nixpkgs) lib;

    # List of hosts and their specifications
    hosts = import ./hosts { inherit inputs; };
    users = import ./users { inherit inputs; };
    # Nixos and home modules
    nixos = import ./modules/nixos;
    home = import ./modules/home;
    # dots = import ./dotfiles;
    scripts = import ./scripts;
    # modules = import ./modules;

    # Get the systems within hosts attrs, lib.unique to prevent duplicates
    systems = lib.unique (lib.attrValues (lib.mapAttrs (_: cfg: cfg.system) hosts));
    # systems = lib.attrValues (lib.mapAttrs (_: cfg: cfg.system) hosts);
    forAllSystems = lib.genAttrs systems;

    # set of args to pass in
    args = { inherit self inputs lib users nixos home scripts; };
    # function to build hosts
    _lib = import ./lib args;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    # Custom packages
    # packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});
    overlays = import ./overlays { inherit inputs; };
    # devShell = forAllSystem (system: ${system}.default = import ./shell.nix { inherit pkgs; });

    # nixosModules = { default = ./nixos; };
    # homeModules = { default = ./home; };

    # GENERATE HOSTS|HOMES CONFIGURATION
    nixosConfigurations = lib.mapAttrs _lib.mkHost hosts;
    # darwinConfigurations = lib.mapAttrs _lib.mkHost hosts;
    # homeConfigurations = lib.mapAttrs' _lib.mkHome hosts;
  };
}
