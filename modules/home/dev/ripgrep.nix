{ pkgs, ... }:
{
  programs.ripgrep = {
    enable = true;
    package = pkgs.unstable.ripgrep;
    arguments = [
      "--smart-case"
      "--max-columns-preview"
      "--colors=line:style:bold"
    ];
  };
}
