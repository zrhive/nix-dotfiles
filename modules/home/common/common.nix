{ osConfig, inputs, ... }:
{
  imports = [
    inputs.self.modules.common
  ];

  modules.xserver.enable = osConfig.modules.xserver.enable;
  modules.wayland.enable = osConfig.modules.wayland.enable;
}
