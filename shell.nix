let
  d = import ./.;
  pkgs = d.pkgs;
in
pkgs.mkShell {
  packages =
    # builtins.attrValues {
    #   inherit (pkgs)
    #     tree
    #     nixfmt
    #     nixfmt-tree
    #     ;
    # };
    (builtins.attrValues {
      inherit (pkgs)
        tree
        nixfmt
        nixfmt-tree
        ;
    })
    ++ [
      pkgs.gcc
      pkgs.libxcursor
      pkgs.xorg.libXcursor
      pkgs.xorg.libX11
      pkgs.xorg.libXft
      pkgs.pkg-config
    ];
}
