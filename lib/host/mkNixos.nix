{
  inputs,
  hosts,
  users,
  host,
  cfg,
  ...
}: # @args:

let
  # inherit (args) inputs hosts users;
  inherit (cfg) system userList;
  inherit (inputs.nixpkgs.lib)
    # genAttrs
    # attrValues
    # flatten
    nixosSystem
    ;
  nixos = inputs.self.nixosModules;
  home = inputs.self.homeModules;

  specialArgs = {
    inherit (inputs) self;
    inherit
      inputs
      host
      nixos
      userList
      ;
  };

  # userModules = flatten (attrValues (genAttrs userList (user: [ users.${user}.default ])));
  userModules = map (user: users.${user}.default) userList;
  home-manager = [
    (home.nixos {
      inherit
        inputs
        users
        userList
        home
        ;
    })
    inputs.home-manager.nixosModules.home-manager
  ];
  modules = hosts.${host}.imports ++ userModules ++ home-manager;
in
nixosSystem { inherit system specialArgs modules; }
