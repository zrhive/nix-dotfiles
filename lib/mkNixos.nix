# { self, inputs, lib, users, nixos, home, dots, scripts,
#   host, system, userList, moduleList, stateVersion, ... } @ args:

# { host, system, userList, moduleList, ... } @ args:
{ host, cfg, ... } @ args:

let
  inherit (args) self inputs lib nixos home users;
  inherit (cfg) system userList moduleList;
  inherit (lib) genAttrs attrValues flatten;

  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      self.overlays.unstable-packages
    ];
  };

  specialArgs = { inherit inputs nixos host userList; };
  # extraSpecialArgs = { inherit self inputs home dots scripts; };

  userDefault = genAttrs userList (user: [ users.${user}.default ]);
  extraModules = flatten (moduleList ++ (attrValues userDefault));

in lib.nixosSystem {
  inherit system;
  inherit specialArgs;

  modules = extraModules ++ [
    { nixpkgs.pkgs = pkgs; }
    (home.nixos (args // { inherit userList; }))
    # (home.nixos { inherit users; } // extraSpecialArgs)
    inputs.home-manager.nixosModules.home-manager
    # {
    #   home-manager = {
    #     inherit extraSpecialArgs;
    #     useGlobalPkgs = true;
    #     useUserPackages = true;
    #     backupFileExtension = "backup";
    #     users = genAttrs userList (user: {
    #       imports = [
    #         (home.default { inherit user stateVersion; })
    #         users.${user}.home
    #       ];
    #     });
    #   };
    # }
  ];
}
