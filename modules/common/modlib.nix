{ config, ... }:
{
  config = {
    isEnable =
      module:
      (builtins.hasAttr module config.enableModules && config.enableModules.${module})
      || builtins.elem module config.listModules;
  };
}
