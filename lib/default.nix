{ ... } @ args:

let
  inherit (args) lib;
in

{
  mkHost = host: cfg: import ./mkNixos.nix (args // {
    inherit host cfg;
    inherit (cfg) system userList moduleList stateVersion;
  });

  # mkHost = host: cfg: if lib.hasSuffix "linux" cfg.system
  #   then import ./mkNixos.nix (args // {
  #     inherit host cfg;
  #     inherit (cfg) system userList moduleList stateVersion;
  #   })
  # else import ./mkDarwin.nix (args // {
  #   inherit host cfg;
  #   inherit (cfg) system userList moduleList stateVersion;
  # });

  mkHome = host: cfg: let user = lib.attrsName (
    lib.genAttrs cfg.userList (user: {}));
  in lib.nameValuePair ("${user}@${host}") (
    import ./mkHome.nix (args // { inherit host cfg; })
  );

  nixdots = import ./nixdots.nix;
}
