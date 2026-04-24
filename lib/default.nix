{ ... }@args:

args.inputs.nixpkgs.lib.makeExtensible (
  self:
  let
    callLibs = file: import file (args // { inherit self; });
  in
  {
    host = callLibs ./host;
    platform = callLibs ./platform.nix;
    extract = callLibs ./extract.nix;

    inherit (self.host)
      mkNixos
      mkDarwin
      mkHost
      mkHome
      ;
    inherit (self.platform)
      isLinux
      isDarwin
      systemList
      eachSystem
      ;
    inherit (args.inputs.nixpkgs.lib)
      mapAttrs
      genAttrs
      attrValues
      attrNames
      listToAttrs
      concatLists
      unique
      map
      hasSuffix
      flatten
      ;
  }
)
