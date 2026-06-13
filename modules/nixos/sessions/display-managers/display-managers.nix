{ config, lib, ... }:
{
  services.displayManager = {
    enable = lib.mkIf (
      config.modules.graphical.display.manager != ""
      && config.modules.graphical.display.manager != "lightdm"
    ) true;
    /**
      Commented option.
      Display manager, lemurs and ly
      doesn't support auto login
    */
    # autoLogin = {
    #   enable = true;
    #   user = elemAt hostConfig.users 0;
    # };
  };
}
