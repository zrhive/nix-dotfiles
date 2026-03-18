let
  d = import ./.;
  pkgs = d.pkgs;
in
pkgs.mkShellNoCC {
  packages = builtins.attrValues {
    inherit (pkgs)
      tree
      nixfmt
      nixfmt-tree
      ;
  };
}
