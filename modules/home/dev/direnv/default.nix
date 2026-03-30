{ inputs, ... }:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    silent = true;
    nix-direnv.enable = true;
  };

  imports = [ inputs.direnv-instant.homeModules.direnv-instant ];
  programs.direnv-instant.enable = true;
}
