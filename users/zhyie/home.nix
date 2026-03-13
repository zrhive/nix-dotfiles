{ config, lib, pkgs, home, dots, scripts, ... }:

let
  inherit (lib) attrValues;
  sc = scripts { inherit pkgs; };

  outLink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    ".gitconfig" = { source = outLink "${config.home.homeDirectory}/.gitconfig"; };
  };

  dotfiles.configFiles = [
    "picom" "kitty" "rofi" "yazi"
    # "dunst"
  ];

  imports = [
    home.programs.default
    home.services.default
    home.themes.default
    dots.dotfiles
  ];
  home.packages = attrValues {
    inherit (sc) hello;
  };
}
