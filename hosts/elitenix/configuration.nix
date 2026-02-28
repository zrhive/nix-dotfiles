# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, modules, ... }:

{
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./laptop-behavior.nix

      ./locale.nix
      ./environment.nix

      modules.core
      modules.hardware
      modules.services
  ];

  boot.kernelParams = [ "i915.enable_guc=2" ];
  hardware.intelgpu.vaapiDriver = "intel-media-driver";

  # Console settings.
  console = {
    font = "sun12x22";
    keyMap = "us";
  };

  #######################################
  #   OFF LIMIT  SYSTEM STATE VERSION   #
  #######################################
  # Do NOT change, unless all the changes it would make to a configuration
  # have been manually inspected and the data is migrated accordingly.
  #
  # For more information, see `man configuration.nix` or
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "25.11";
}
