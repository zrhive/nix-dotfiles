{ pkgs, ... }:

{
  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.mochaPink;
    name = "catppuccin-mocha-pink-cursors";
    size = 16;

    x11.enable = true;
    gtk.enable = true;
  };
}
