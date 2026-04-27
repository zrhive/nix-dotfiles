{
  inputs,
  users,
  userList,
  home,
  ...
}:
let
  inherit (inputs.nixpkgs.lib) genAttrs;
  extraSpecialArgs = { inherit inputs home; };
in
{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = genAttrs userList (user: {
      imports = [
        (import ./home.nix { inherit user; })
        users.${user}.home
      ];
    });
  };
}
