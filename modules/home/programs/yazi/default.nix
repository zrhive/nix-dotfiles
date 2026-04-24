{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi.override { _7zz = pkgs._7zz-rar; };
    shellWrapperName = "y";
    enableBashIntegration = true;
    enableNushellIntegration = true;
    extraPackages = builtins.attrValues {
      inherit (pkgs)
        ueberzugpp
        glow
        ouch
        lazygit
        xclip
        mediainfo
        trash-cli
        ;
    };
  };
}
