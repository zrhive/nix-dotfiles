{ config, pkgs, ... }:
{
  home.sessionVariables.VISUAL = "nvim";

  programs.neovim = {
    enable = config.modules.dev.enable;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;

    extraPackages = [
      pkgs.lua54Packages.luacheck
    ]
    ++ builtins.attrValues {
      inherit (pkgs)
        ripgrep
        fzf
        xclip
        gitMinimal
        tree-sitter
        ;
    };

    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.nix
      ]))
    ];
  };
}
