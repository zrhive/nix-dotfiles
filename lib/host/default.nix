{ self, ... }@args:

let
  inherit (self)
    isLinux
    isDarwin
    concatLists
    mapAttrs
    attrValues
    map
    ;
in
{
  mkNixos = host: cfg: isLinux cfg.system (import ./mkNixos.nix (args // { inherit host cfg; }));
  mkDarwin = host: cfg: isDarwin cfg.system (import ./mkNixos.nix (args // { inherit host cfg; }));

  # mkHome =
  #   attrs:
  #   concatLists (
  #     attrValues (
  #       mapAttrs (
  #         host: cfg:
  #         map (user: {
  #           name = user + "@" + host;
  #           value = import ./mkHome.nix (args // { inherit host cfg; });
  #         }) cfg.userList
  #       ) attrs
  #     )
  #   );
  mkHome =
    attrs:
    let
      hostList = mapAttrs (
        user: cfg:
        map (host: {
          name = host;
          value = import ./mkHome (args // { inherit user cfg; });
        }) cfg.hostList
      ) attrs;
    in
    concatLists (attrValues hostList);

  mkHost =
    host: cfg:
    if self.hasSuffix "linux" cfg.system then
      import ./mkNixos.nix (
        args
        // {
          inherit host cfg;
        }
      )
    else
      import ./host/mkDarwin.nix (
        args
        // {
          inherit host cfg;
        }
      );

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
