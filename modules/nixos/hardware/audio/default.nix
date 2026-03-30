let
  pipewire = import ./pipewire.nix;
in
{
  imports = [
    pipewire
  ];
}
