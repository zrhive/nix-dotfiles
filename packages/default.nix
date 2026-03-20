{ pkgs, ... }:
{

  scripts = pkgs.callPackages ./scripts { };
}
