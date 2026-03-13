{ config, lib, dots, ... }:

let
  inherit (lib) mkOption types genAttrs;
  cfg = config.dotfiles;

  outLink = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.dotfiles = {
    configFiles = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        List of configs to be set to {option}`xdg.config`.
      '';
    };

    homeFiles = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        List of home files to be set to {option}`home.file`.
      '';
    };
  };

  config = {
    xdg.configFile = genAttrs cfg.configFiles (name: {
      source = outLink "${config.home.homeDirectory}/.os/dotfiles/${name}";
      recursive = true;
    });

    home.file = genAttrs cfg.homeFiles (name: {
      source = outLink "${config.home.homeDirectory}/.os/dotfiles/${name}";
      recursive = true;
    });
  };
}
