{ inputs, ... }:

let
  inherit (inputs) catppuccin sops-nix;
in
{
  zhyie = {
    default = import ./zhyie;
    home    = import ./zhyie/home.nix;
    hostList = [ "zhyie@elitenix" ];
    moduleList = [
      catppuccin.homeModules.catppuccin
      sops-nix.homeModules.sops
    ];
  };
}
