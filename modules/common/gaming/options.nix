{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkOption types;
in
{
  options.modules.gaming = {
    enable = mkEnableOption "Enable gaming modules.";

    #: Placeholders for the list of packages to install.
    packages = {
      nixpkgs = mkOption {
        type = types.nullOr (types.listOf types.package);
        description = "Final list of packages.";
      };
      flatpaks = mkOption {
        type = types.nullOr (types.listOf types.str);
        description = "Final list of packages.";
      };
    };

    #: `games.<gameName>.<gameConfig>`
    # games = genAttrs gameList gameConfig;
    games = mkOption {
      type = types.attrsOf (
        types.submodule (
          { name, ... }:
          {
            options = {
              enable = mkEnableOption "Enable ${name}.";
              version = mkOption {
                type = types.enum [
                  "nixpkgs"
                  "flatpak"
                ];
                default = "nixpkgs";
                description = "Package version to use.";
              };
              packages = mkOption {
                type = types.nullOr (types.listOf (types.either types.package types.str));
                default = [ ];
                description = "List of packages for this game.";
              };
            };
          }
        )
      );
      default = { };
      description = "Games with config.";
    };
  };

  config = {
    service.flatpak = {
      enable = lib.mkDefault lib.any (game: game.enable && game.version == "flatpak") (
        lib.attrValues config.modules.gaming.games
      );

      packages = lib.concatMap (
        game: lib.optionals (game.enable && game.version == "flatpak") game.packages
      ) (lib.attrValues config.modules.gaming.games);
    };
  };
}
