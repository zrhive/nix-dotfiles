{
  inputs, lib, xmodules, users, modules, home,
  host, system, userList, moduleList ? [], stateVersion,
  ...
}:

let
  inherit (inputs)  home-manager;

  extraArgs = {
    inherit inputs modules home host userList stateVersion;
  };

  userModules = lib.genAttrs userList (user: [ users.${user}.default ]);
  extraModules = xmodules ++ moduleList ++ (lib.attrValues userModules);

  # home-manager = nixosModules.home-manager;
in

lib.nixosSystem {
  inherit system;
  specialArgs = extraArgs;

  modules = lib.flatten (extraModules ++ [
    home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = extraArgs;
        users = lib.genAttrs userList (user: {
          imports = [
            (home.default { inherit user; })
            users.${user}.home
          ];
        });
      };
    }
  ]);
}
