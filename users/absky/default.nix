{ pkgs, ... }:
{
  users.users.absky = {
    extraGroups = [ "lpadmin" ];

    packages = [ pkgs.ungoogled-chromium ];
  };
}
