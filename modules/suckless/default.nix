# ############################################
# suckless.org
# --------------------------------------------
# software that sucks less
# https://suckless.org/
# --------------------------------------------
# dwm: https://dwm.suckless.org/
# slstatus: https://tools.suckless.org/dmenu/
# dmenu: https://tools.suckless.org/slstatus/
# st: https://st.suckless.org/
# ############################################

{ pkgs, ... }:

let
  packdwm      = pkgs.dwm.overrideAttrs { src = ./dwm; };
  packslstatus = pkgs.slstatus.overrideAttrs { src = ./slstatus; };
  packdmenu    = pkgs.dmenu.overrideAttrs { src = ./dmenu; };
  packst       = pkgs.st.overrideAttrs { src = ./st; };
in {
  services.xserver.windowManager.dwm = {
    enable = true;
    package = packdwm;
  };

  environment.systemPackages = [
    packslstatus
    packdmenu
    packst
  ];

  systemd.user.services.slstatus = {
    enable = true;
    description = "Status service for DWM";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.packslstatus}/bin/slstatus &";
    };
  };
}
