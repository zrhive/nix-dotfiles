{ config, pkgs, ... }:
{
  xdg.configFile."nvim" =
    let
      inherit (config.lib.file) mkOutOfStoreSymlink;
      inherit (config.home) homeDirectory;
    in
    {
      source = mkOutOfStoreSymlink "${homeDirectory}/.os/dotfiles/nvim";
    };

  home.sessionVariables = {
    VISUAL = "nvim";
  };

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    withNodeJs = true;

    extraLuaPackages = p: [ p.luacheck ];

    extraPackages = builtins.attrValues {
      inherit (pkgs)
        ripgrep
        fzf
        xclip
        lua-language-server
        stylua
        nixd
        nixfmt
        nixfmt-tree
        alejandra
        deadnix
        statix
        clang
        clang-tools
        gcc
        tree-sitter
        ;
    };

    # plugins = builtins.attrValues {
    #   inherit (pkgs.vimPlugins)
    #     inherit (nvim-treesitter-parsers)
    #       lua nix c markdown
    #     ;
    #
    #     telescope-nvim
    #     telescope-fzf-native-nvim
    #     plenary-nvim
    #
    #     blink-cmp
    #     friendly-snippets
    #     conform-nvim
    #     nvim-lint
    #
    #     alpha-nvim
    #     catppuccin-nvim
    #     lualine-nvim
    #     nvim-web-devicons
    #     yazi-nvim
    #     mini-nvim
    #   ;
    # };
  };
}
