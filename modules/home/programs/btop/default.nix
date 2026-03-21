{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
    packages = pkgs.unstable.btop;
  };
}
