{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkDefault;
  inherit (config.modules.graphical) xserver;
in
{
  imports = [ inputs.suckless.nixosModules.flexipatch ];

  suckless.tools = {
    enable = xserver.dwm;
    dwm.enable = mkDefault true;
    dmenu.enable = mkDefault true;
    st.enable = mkDefault true;
    slstatus.enable = mkDefault true;
  };
}
