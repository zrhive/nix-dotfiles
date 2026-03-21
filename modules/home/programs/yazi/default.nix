{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi;
    shellWrapperName = "y";
    extraPackages = builtins.attrValues {
      inherit (pkgs)
        tar
        lazygit
        mediainfo
        trash-cli
        ;
    };
  };
}
