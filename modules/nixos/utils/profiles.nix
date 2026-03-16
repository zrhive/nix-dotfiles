{ config, lib, ... }:

let
  inherit (lib) mkOption types map;

  importProfile = {
    minimal = import ./minimal.nix;
  };
in
{
  options.vars = {
    profile = mkOption {
      type = types.listOf;
      default = [ "minimal" ];
      description = "Host profile";
    };
  };

  imports = map (profile: importProfile.${profile}) config.vars.profiles;
}
