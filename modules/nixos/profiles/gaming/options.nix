{
  config,
  inputs,
  nixos,
  ...
}:
{
  imports = [
  ];

  config.environment.systemPackages = config.modules.gaming.packages.nixpkgs;
}
