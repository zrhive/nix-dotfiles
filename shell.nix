{ self, pkgs }:

let
  inherit (self.checks.${pkgs.stdenv.hostPlatform.system}.git-hooks)
    shellHook
    enabledPackages
    ;
in
pkgs.mkShellNoCC {
  inherit shellHook;

  packages = enabledPackages ++ [
    self.packages.${pkgs.stdenv.hostPlatform.system}.hm
    pkgs.lua54Packages.luacheck
    pkgs.nixd

    pkgs.bat
  ];
}
