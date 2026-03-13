{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Light";
      size = "32x32";
    };
  };

  xdg.configFile.dunst = {
    source = ${config.home.homeDirectory}/.os/dotfiles/dunst;
    recursive = true;
  };
}
