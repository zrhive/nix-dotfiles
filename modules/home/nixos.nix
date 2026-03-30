{
  inputs,
  users,
  userList,
  home,
  ...
}: # @args:
let
  # inherit (args) inputs users;
  inherit (inputs.nixpkgs.lib) genAttrs;
  # inherit (cfg) userList stateVersion;

  extraSpecialArgs = {
    inherit inputs home;
  };
in
{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = genAttrs userList (user: {
      imports = [
        (home.default { inherit user; })
        users.${user}.home
      ];
    });
  };
}
