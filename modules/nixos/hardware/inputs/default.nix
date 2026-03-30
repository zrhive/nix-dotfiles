{
  # mouse = import ./mouse.nix;
  # touchpad = import ./touchpad.nix;
  # trackpoint = import ./trackpoint.nix;

  imports = [
    ./mouse.nix
    ./touchpad.nix
    ./trackpoint.nix
  ];
}
