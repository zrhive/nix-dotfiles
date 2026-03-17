{
  system ? builtins.currentSystem,
  pkgs ? (import ./.).pkgs,
}:

pkgs.mkShell {
  packages = builtins.attrValues {
    inherit (pkgs)
      tree
      nixfmt
      nixfmt-tree
      nixpkgs-fmt
      ;
  };
}
