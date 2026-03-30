{
  writeScriptBin,
  callPackage,
  inputs,
}:

let
  inherit (builtins)
    attrNames
    readDir
    readFile
    listToAttrs
    replaceStrings
    map
    ;

  dir = inputs.dotfiles + "/scripts";
  scripts' = attrNames (readDir dir);
  scripts = map (s: replaceStrings [ ".sh" ] [ "" ] s) scripts';
  mkScript = name: writeScriptBin name (readFile (dir + "/${name}.sh"));
in
listToAttrs (
  map (script: {
    name = script;
    value = callPackage mkScript scripts { };
  }) scripts
)
