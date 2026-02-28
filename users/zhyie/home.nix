{ lib, pkgs, home, ... }:

{
  # catppuccin.yazi = {
  #   enable = true;
  #   flavor = "macchiato";
  #   accent = "lavender";
  # };

  # Import packages.
  imports = [
    home.programs.default
    home.services.default
    home.themes.default
    # home.programs.git
    # home.programs.neovim
    # home.programs.kitty
    # home.programs.rofi
    # home.programs.yazi
    # home.programs.qimgv
    # home.programs.qimgv
    # ../../programs/bash.nix
    # ../../programs/git.nix
    # ../../programs/neovim.nix
    # ../../programs/kitty.nix
    # ../../programs/rofi.nix
    # ../../programs/yazi.nix
    # ../../programs/qimgv.nix
    # ../../programs/feh.nix
    #
    # ../../themes/fonts.nix
    # ../../themes/icons.nix
    # ../../themes/catppuccin.nix
  ];
}
