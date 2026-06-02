rec {
  catppuccin = import ./catppuccin;
  inherit (catppuccin) console nmtui;
}
