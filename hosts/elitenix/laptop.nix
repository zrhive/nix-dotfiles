{ ... }:
{
  services.xserver = {
    serverFlagsSection = ''
      Option "BlankTime" "0"
      Option "StandbyTime" "10"
      Option "SuspendTime" "20"
      Option "OffTime" "30"
    '';
  };

}
