{ lib, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    genAttrs
    literalExpression
    ;

  moduleList = [
    "desktop"
    "laptop"
    "dev"
    "gaming"
    "graphical"
    "xserver"
    "wayland"
    "shell"
    "themes"
  ];

  mkEnable = name: { enable = mkEnableOption "Enable ${name} modules."; };
in
{
  options.modules = genAttrs moduleList mkEnable // {
    shell.beforeExec = mkOption {
      type = types.lines;
      default = "";
      description = "Commands to run before an exec of shell.";
    };
  };

  options.listModules = mkOption {
    type = types.listOf types.str;
    default = [ ];
    example = literalExpression ''
      listModules = [
        "bash"
        "neovim"
      ];
    '';
    description = ''
      List of pre-configured modules to enable.
    '';
  };

  options.enableModules = mkOption {
    type = types.attrsOf types.bool;
    default = { };
    example = literalExpression ''
      enableModules = {
        bash = true;
        neovim = true;
      };
    '';
    description = ''
      Attr of pre-configured modules to enable.
    '';
  };
}
