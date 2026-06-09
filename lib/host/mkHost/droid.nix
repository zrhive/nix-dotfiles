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
  userName = builtins.head hostConfig.users;
  userModule = [ users.${userName}.user ];

  homeModules = homeModule (args // { inherit userName; });

  baseModules = hostConfig.module ++ userModule;
in
inputs.nixpkgs.lib.nixOnDroidConfiguration {
  pkgs = inputs.nixpkgs-droid.legacyPackages.${hostConfig.system};
  home-manager-path = inputs.home-manager-droid.outPath;

  modules = if hostConfig.withHome then baseModules ++ homeModules else baseModules;

  extraSpecialArgs = {
    inherit (modules) droid;
    inherit
      inputs
      hostName
      hostConfig
      ;
  };
}
