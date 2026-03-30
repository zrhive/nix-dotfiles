{ self }@args:
{
  # mkHost =
  #   host: cfg:
  #   if lib.hasSuffix "linux" cfg.system then
  #     import ./mkNixos.nix (
  #       args
  #       // {
  #         inherit host cfg;
  #       }
  #     )
  #   else
  #     import ./host/mkDarwin.nix (
  #       args
  #       // {
  #         inherit host cfg;
  #       }
  #     );

  mkNixos = host: cfg: self.isLinux cfg.system (import ./mkNixos.nix { inherit host cfg; } // args);
  mkDarwin =
    host: spec: self.isDarwin spec.system (import ./mkDarwin.nix { inherit host spec; } // args);

  /*
    nix-repl> builtins.concatLists ((builtins.attrValues (builtins.mapAttrs (h: c: builtins.map (u: u + "@" + h) c.users) { host1 = { users = [ "user1" ]; }; })))
    => [ "user1@host1" ]
  */
  # mkHome =
  #   attrs:
  #   let
  #     inherit (builtins)
  #       concatLists
  #       attrValues
  #       mapAttrs
  #       map
  #       ;
  #     userList = mapAttrs (host: cfg: map (user: userHost user host { inherit cfg; }) cfg.userList) attrs;
  #     userHost = user: host: args: {
  #       name = user + "@" + host;
  #       value = import ./mkHome.nix args;
  #     };
  #   in
  #   concatLists (attrValues userList);
}
