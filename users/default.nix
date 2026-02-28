{
  zhyie = {
    default = import ./zhyie;
    home    = import ./zhyie/home.nix;
  };

  # user for non nixos
  # riri = {
  #     home = import ./riri;
  # };

  absky = {
    default = import ./absky;
  };
}
