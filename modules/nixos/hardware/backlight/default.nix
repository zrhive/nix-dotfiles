{ ... }:
{
  imports = [ ./opts.nix ];

  # Enable backlight.
  programs.light.enable = true;
}
