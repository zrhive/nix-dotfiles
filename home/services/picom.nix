{ lib, pkgs, ... }:

let
  inherit (lib) getExe;
  picom = pkgs.unstable.picom;
  #conf = ${config.xdg.configFile."picom".source};
in
{
  home.packages = [ picom ];

  systemd.user.services.picom = {
    Unit = {
      Description = "Picom X11 compositor";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      # ExecStart = "${lib.getExe pkgs.unstable.picom} --config ${dots.picom}/picom.conf";
      ExecStart = "${getExe picom}";
      Restart = "always";
      RestartSec = 3;
    };
  };
}
