{
  inputs,
  users,
  home,
  system,
  userList,
  ...
}:
let
  inherit (inputs.nixpkgs.lib) genAttrs attrValues flatten;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  extraSpecialArgs = {
    inherit (inputs) self;
    inherit inputs home;
  };

  userModules = genAttrs userList (user: [
    (import ./home.nix { inherit user; })
    users.${user}.home
  ]);
  modules = flatten (attrValues userModules);
in
homeManagerConfiguration {
  inherit pkgs extraSpecialArgs modules;
}
