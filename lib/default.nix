{ ... } @ args:

let
  inherit (args) lib;
in
{
  utils = import ./utils;

  # mkHost = host: cfg: import ./mkNixos.nix (args // {
  #   inherit host;
  #   inherit (cfg) system userList moduleList stateVersion;
  # });

  mkHost = host: cfg: if lib.hasSuffix "linux" cfg.system
    then import ./mkNixos.nix (args // {
      # inherit host; inherit (cfg) system userList moduleList;
      inherit host cfg;
    })
    else import ./mkDarwin.nix (args // {
      inherit host; inherit (cfg) system userList moduleList;
    });

  # mkHome = host: cfg: let user = lib.attrsName (
  #   lib.genAttrs cfg.userList (user: {}));
  # in lib.nameValuePair ("${user}@${host}") (
  #   import ./mkHome.nix (args // { inherit host cfg; })
  # );
}
