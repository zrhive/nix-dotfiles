{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Light";
      size = "32x32";
    };
    settings = {};
    configFile = ../../config/dunst/dunstrc;
  };
}


