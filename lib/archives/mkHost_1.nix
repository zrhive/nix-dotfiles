{
  inputs, lib, nixpkgs, users, modules, home, _modules, host,
  system, userList, moduleList ? [], stateVersion,
  ...
}:

let
  pkgs = nixpkgs.legacy.${system};
  extraArgs = { inherit inputs lib pkgs modules home host userList stateVersion; };

  userModules = lib.genAttrs userList (user: [ users.${user}.user ]);
  extraModules = _modules ++ moduleList ++ (lib.attrValues userModules);

  home-manager = inputs.home-manager.nixosModules.home-manager;

in lib.nixosSystem {
  inherit system;
  specialArgs = extraArgs;

  modules = [
    home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecilArgs = extraArgs;
        users = lib.genAttrs userList (user: {
          imports = [
            home.default
            users.${user}.home
          ];
        });
      };
    }
  ] ++ extraModules;
}
