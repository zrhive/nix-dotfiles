rec {
  #: Audio
  pipewire = ./pipewire.nix;

  #: Bluetooth
  bluetooth = ./bluetooth.nix;

  #: Backlight
  backlight = import ./backlight;
  inherit (backlight) brightnessctl light;

  #: Input
  input = import ./input;
  inherit (input) mouse touchpad trackpoint;

  #: Printing and Scanner
  printing = ./printing.nix;
  sane = ./sane.nix;
}
