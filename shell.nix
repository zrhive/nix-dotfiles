let
  pkgs = (import ./.).pkgs;
in

pkgs.mkShell {
  packages = builtins.attrValues {
    inherit (pkgs)
      tree
      nixfmt-tree git
      lua-language-server
    ;
  };
}
