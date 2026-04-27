{
  inputs,
  users,
  host,
  cfg,
  ...
}:
let
  inherit (cfg)
    module
    system
    userList
    profileList
    ;
  inherit (inputs.nixpkgs.lib) nixosSystem;
  nixos = inputs.self.nixosModules;
  home = inputs.self.homeModules;

  specialArgs = {
    inherit
      inputs
      host
      nixos
      userList
      ;
  };

  # hostProfiles = map (profile: nixos.profiles.${profile}) profileList;
  hostProfiles = map (profile: nixos.profiles.${profile}) (
    if profileList == null then [ "minimal" ] else [ "minimal" ] ++ profileList
  );
  userModule = map (user: users.${user}.default) userList;
  home-manager = [
    inputs.home-manager.nixosModules.home-manager
    (import ./mkHome/nixos.nix {
      inherit
        inputs
        users
        userList
        home
        ;
    })
  ];
  modules = module ++ userModule ++ hostProfiles ++ home-manager;
  # modules = module ++ userModule ++ home-manager;
in
nixosSystem { inherit system specialArgs modules; }
