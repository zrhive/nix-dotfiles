{ config, lib, pkgs, ... }:

let

  outLink = config.lib.file.mkOutOfStoreSymlink;
  homePath = config.home.homeDirectory;

in {
  # home.file.".config/nvim" = {
  #   source = builtins.readFile ../../config/nvim;
  # };

  xdg.configFile."nvim" = {
    source = outLink "${homePath}/.dotfiles/config/nvim";
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };
}
