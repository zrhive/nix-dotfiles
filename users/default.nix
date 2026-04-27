{
  zhyie = {
    default = import ./zhyie;
    home = import ./zhyie/home.nix;
    hostList = [
      "zhyie"
      "zhyie@elitenix"
    ];
    profileList = [ "workstation" ];
  };
}
