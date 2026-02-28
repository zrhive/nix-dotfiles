{ pkgs, ... }:

{
  environment.etc."picom/picom.conf" = {
    source = ../../config/picom/picom.conf;
  };

  environment.systemPackages = with pkgs; [ picom ];

  services.picom = {
    enable = true;
  };
}
