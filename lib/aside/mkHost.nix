{ inputs, lib, xmodules, users, modules, home, ... }:

host: cfg:

let
  inherit (inputs)  home-manager;
  inherit (cfg)     system userList moduleList stateVersion;

  extraArgs = {
    inherit inputs modules home host userList stateVersion;
  };

  userModules = lib.genAttrs userList (user: [ users.${user}.user ]);
  extraModules = xmodules ++ moduleList ++ (lib.attrValues userModules);

  # home-manager = nixosModules.home-manager;
in

lib.nixosSystem {
  inherit system;
  specialArgs = extraArgs;

  modules = extraModules ++ [
    home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecilArgs = extraArgs;
        users = lib.genAttrs userList (user: {
          imports = [
            (home.default { inherit user; })
            users.${user}.home
          ];
        });
      };
    }
  ];
}
