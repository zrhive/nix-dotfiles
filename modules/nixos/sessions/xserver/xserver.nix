{ config, lib, ... }:
{
  services.xserver = {
    enable = config.modules.xserver.enable;
    autoRepeatDelay = 300;
    autoRepeatInterval = 45;

    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "10"
      Option "SuspendTime" "20"
      Option "OffTime" "30"
    '';

    /**
      wallpaper via desktop manager
      images in `~/.background-image`
      mode: center, fill, scale, max, tile
    */
    desktopManager.wallpaper.mode = lib.mkDefault "scale";
  };
}
