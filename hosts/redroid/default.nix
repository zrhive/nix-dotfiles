{ droid, ... }:
{
  imports = [
    ./configuration.nix
    droid.profiles.base
  ];
}
