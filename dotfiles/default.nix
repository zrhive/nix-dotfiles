{
  configFile = import ./configFile.nix;
  dotfiles = import ./dotfiles.nix;

  dunst   = ./dunst;
  feh     = ./feh;
  kitty   = ./kitty;
  nvim    = ./nvim;
  picom   = ./picom;
  rofi    = ./rofi;
  yazi    = ./yazi;
}
