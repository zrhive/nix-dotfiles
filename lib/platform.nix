{ inputs, hosts, ... }:

let
  inherit (inputs.nixpkgs.lib)
    attrValues
    mapAttrs
    genAttrs
    filterAttrs
    hasSuffix
    unique
    ;
in
rec {
  filterNixos = attrs: filterAttrs (_: c: c.platform == "nixos") attrs;
  filterDarwin = attrs: filterAttrs (_: c: c.platform == "darwin") attrs;
  filterWsl = attrs: filterAttrs (_: c: c.platform == "wsl") attrs;
  filterDroid = attrs: filterAttrs (_: c: c.platform == "droid") attrs;

  isLinux = platform: hasSuffix "linux" platform;
  isDarwin = platform: hasSuffix "darwin" platform;

  systemList = unique (attrValues (mapAttrs (_: host: host.system) hosts));
  eachSystem = f: genAttrs systemList (system: f inputs.nixpkgs.legacyPackages.${system});
}
