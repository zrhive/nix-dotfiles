{ pkgs, inputs }:
{
  scripts = pkgs.callPackage ./scripts.nix { inherit inputs; };
}
