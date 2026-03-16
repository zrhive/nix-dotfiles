{ inputs, ... }:

let
  inherit (inputs) nixos-hardware sops-nix;
  hardware = nixos-hardware.nixosModules;
in
{
  elitenix = {
    system = "x86_64-linux";
    userList = [ "zhyie" ];
    moduleList = [
      ./elitenix
      hardware.hp-elitebook-830g6
      hardware.common-gpu-intel
      sops-nix.nixosModules.sops
      # suckless.nixosModules.default
      (import inputs.suckless)
    ];
    stateVersion = "25.11";
  };
}
