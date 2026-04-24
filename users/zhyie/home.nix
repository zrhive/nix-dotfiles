{ home, pkgs, ... }:
{
  imports = [
    home.programs.default
    home.services.default
    home.themes.default
    home.dev
    home.utils
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs.unstable) discord;
    inherit (pkgs) scripts;
  };

  home.file = {
    ".gitconfig".source = ./.gitconfig;
  };

  dotfiles.configFiles = [
    "picom"
    "kitty"
    "rofi"
    "yazi"
    "btop"
  ];
}
