{
  inputs,
  users,
  modules,
  hostName,
  hostConfig,
  homeModule,
  ...
}@args:

let
  homeModules = map (userName: homeModule (args // { inherit userName; })) hostConfig.users;
  homeManager = [ inputs.home-manager.nixosModules.home-manager ] ++ homeModules;

  userModule = map (userName: users.${userName}.user) hostConfig.users;
  baseModules =
    hostConfig.module
    ++ userModule
    ++ [
      modules.common
      modules.nixos.profiles.base
    ];
in
inputs.nixpkgs.lib.nixosSystem {
  inherit (hostConfig) system;
  modules = if hostConfig.withHome then baseModules ++ homeManager else baseModules;

  specialArgs = {
    inherit (modules) nixos;
    inherit inputs hostName hostConfig;
  };
}
