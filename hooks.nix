{ inputs, pkgs }:

inputs.git-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
  src = ./.;
  package = pkgs.prek;

  default_stages = [ "pre-push" ];

  excludes = [
    "^hosts/.*/hardware-configuration.nix$"
    "^dotfiles/.*"
    "^secrets/.*"
  ];

  hooks = {
    nixfmt.enable = true;

    deadnix = {
      enable = true;
      settings = {
        edit = true;
        noLambdaPatternNames = true;
      };
    };

    statix = {
      enable = true;
      entry = "${pkgs.statix}/bin/statix fix -c ${./statix.toml}";
    };
  };
}
