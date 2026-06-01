{ pkgs, ... }:
{
  imports = [ ./backlight.nix ];

  modules.backlight = {
    enable = true;
    package = pkgs.brightnessctl;

    flags = {
      minimum = "--min-value";
      increase = "set";
      decrease = "set";
    };
  };
}
