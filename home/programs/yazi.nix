{ pkgs, ... }:
{
  # home.packages = [ pkgs.yazi ];
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi;
    shellWrapperName = "y";

    plugins = {
      inherit (pkgs.yaziPlugins)
        sudo mount
        full-border toggle-pane
        mediainfo ouch
        recycle-bin restore
        smart-enter smart-filter
      ;
    };
  };
}
