rec {
  #: Audio
  audio = import ./audio;
  inherit (audio) pipewire;

  #: Bluetooth
  bluetooth = ./bluetooth;

  #: Backlight
  backlight = import ./backlight;
  inherit (backlight) brightnessctl light;

  #: Input
  input = import ./input;
  inherit (input) mouse touchpad trackpoint;

  #: Power
  power = ./power;

  #: Printing
  printing = import ./printing;
}
