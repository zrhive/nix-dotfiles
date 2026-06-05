{ config, pkgs, ... }:
{
  programs.git = {
    # enable = config.modules.dev.enable;
    enable = true;
    package = pkgs.gitMinimal;

    settings = {
      user = {
        name = config.variables.git.user;
        email = config.variables.git.email;
      };

      init.defaultBranch = "main";
    };
  };
}
