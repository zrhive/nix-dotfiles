{ pkgs, inputs, ... }:

let
  dir = inputs.dotfiles + "/scripts";
  scripts' = builtins.attrNames (builtins.readDir dir);
  scripts = ;
  mkScript = script: pkgs.writeScriptBin script (builtins.readFile dir + "${script}");
in
mkScript scripts
