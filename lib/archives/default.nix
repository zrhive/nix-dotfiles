{ inputs, outputs, lib, xmodules, ... }:

{
  mkHost = import ./mkHost.nix {
    inherit inputs outputs lib xmodules;
  };
  # mkHome = import ./mkHome.nix {
  #   inherit inputs self lib;
  # };
}

  # mkHome = hostname: cfg: import ./mkHome.nix {
  #   inherit hostname;
  #   inherit (cfg) users;
  #   _inherits;
  # };
/*

  mkHost = import ./mkHost.nix (_inherits // {
    inherit host;
    inherit (cfg) system userList moduleList stateVersion;
  });
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
