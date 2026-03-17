{ lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (types)
    nullOr
    either
    str
    path
    ;

  # homeDir = config.home.homeDirectory;
  # vars = config.vars;
in
{
  options.vars = {
    flake = mkOption {
      type = nullOr (either str path);
      default = "flake";
      description = "Path of the nixos flake directory.";
    };

    user = {
      name = mkOption {
        type = str;
        description = "User name.";
      };
      email = mkOption {
        type = str;
        description = "User email.";
      };
    };
  };

  # config.vars = {
  #   flake = "${homeDir}/${vars.flake}";
  # };
}
