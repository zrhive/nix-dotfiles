{
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home) homeDirectory;

  dunst = pkgs.dunst;
in
{
  # services.dunst = {
  #   enable = true;
  #   iconTheme = {
  #     package = pkgs.papirus-icon-theme;
  #     name = "Papirus";
  #     size = "32x32";
  #   };
  #
  #   configFile = inputs.dotfiles + "/dunst/dunstrc";
  # };

  xdg.configFile.dunst = {
    source = mkOutOfStoreSymlink (homeDirectory + "/.os/dotfiles/dunst");
  };

  home.packages = [ dunst ];
  dbus.packages = [ dunst ];

  systemd.user.services.dunst = {
    Unit = {
      Description = "Dunst notification daemon";
      Documentation = [ "man:dunst(1)" ];
      PartOf = [ "graphical-session.target" ];
      X-Reload-Triggers = [
        (inputs.dotfiles + "/dunst/dunstrc")
      ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = [ "${dunst}/bin/dunst" ];
      ExecReload = "${dunst}/bin/dunstctl reload";
    };
  };
}
