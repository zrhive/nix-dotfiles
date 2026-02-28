{ inputs, lib, nixpkgs, users, modules, home, _modules, ... }:

host: cfg: let
  pkgs = nixpkgs.legacy.${cfg.system};

  userModules = {
    default = lib.genAttrs cfg.userList (user: [ users.${user}.default ]);
    home = lib.genAttrs cfg.userList (user: [ users.${user}.home ]);
  };
  hostModules = _modules ++ cfg.moduleList ++ userModules.default;
  homeModules = home.default ++ userModules.home;

  _inherits = { inherit inputs lib pkgs; inherit (cfg) userList stateVersion };
  hostArgs = (_inherits // { inherit host modules; inherit (cfg) system moduleList; });
  homeArgs = (_inherits // { inherit home; });

  mkHost = import ./mkHost.nix;
  # mkHome = import ./mkHome.nix {};
in {
  mkHost = import (hostArgs);

}

  # mkHome = hostname: cfg: import ./mkHome.nix {
  #   inherit hostname;
  #   inherit (cfg) users;
  #   _inherits;
  # };
/*

{
  mkHome = host: cfg: nameValuePair ("${cfg.user}@${host}") (import ./mkHome.nix {
    inherit host;
    inherit (cfg) users;
    _inherits;
  });
}


homeConfigurations = lib.mapAttrs' (host: cfg: "${cfg.user}@${host}") hosts;
lib.mapAttrs' (n: v: nameValuePair ("{cfg.user}@${host}") (import ./mkHome.nix)) attrs;
homeConfigurations = lib.mapAttrs (host: cfg:
  lib.genAttrs cfg.users (user: lib.nameValuePair "${user}@${host}" (import ./mkHome.nix))
) hosts

home-manager =
  lib.mapAttrs' (host: cfg:
    lib.nameValuePair
      lib.attrValues ((lib.genAttr cfg.users (user: "${user}@${host}"))) # { user = "user@host" }
    (import ./mkHome.nix))
  hosts;

*/
