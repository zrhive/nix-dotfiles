{ inputs, outputs, lib, nixpkgs, system, users ? [], ... }:

let
  userModules = lib.genAttrs users (name: [ output.users.${name}.home ]);

  homeConfiguration = home-manager.lib.homeManagerConfiguration;
  pkgs = nixpkgs.legacyPackages.${system};
  args = { inherit inputs outputs lib pkgs; };

in homeConfiguration {
  inherit pkgs;
  extraSpecialArgs = { args };
  modules = [ userModules ];
}
