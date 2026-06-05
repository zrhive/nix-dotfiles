{
  # config,
  inputs,
  lib,
  nixos,
  ...
}:
{
  imports = [
    # inputs.nix-flatpak.nixosModules.nix-flatpak
    nixos.services.ssh
  ];

  #: portal definitions and DE provided configurations get linked
  # environment.pathsToLink = lib.optionals config.services.flatpak.enable [
  #   "/share/xdg-desktop-portal"
  #   "/share/applications"
  # ];

  /**
    Set pre-configured nanorc with lib.mkDefault,
    so hosts can override the nano configuration.
  */
  programs.nano.nanorc = lib.mkDefault (lib.readFile "${inputs.dotfiles}/.nanorc");
}
