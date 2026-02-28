{ inputs, ... }:

let
  inherit (inputs.nixos-hardware) nixosModules;
in

{
  elitenix = {
    system = "x86_64-linux";
    userList = [ "zhyie" ];
    moduleList = [
      ./elitenix
      nixosModules.hp-elitebook-830g6
      nixosModules.common-gpu-intel
    ];
    stateVersion = "25.11";
  };
  # asunix = {
  #   system = "x86_64-linux";
  #   users = [ "absky" ];
  #   modules = [];
  # };
  # samnix = {
  #   system = "x86_64-linux";
  #   users = [ "absky" ];
  #   modules = [];
  # };
}
