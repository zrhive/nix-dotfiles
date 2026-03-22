{ pkgs, inputs, ... }:
{
  users.users.zhyie = {
    extraGroups = [ "wheel" ];
    shell = pkgs.nushell;
    # openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIClErKJYbgALjJBXGxGyTrO/DdbHXK1sHkYh+xQjxVE5 zhyie@nixos"
    # ];
    openssh.authorizedKeys.keyFiles = [
      (inputs.secrets + "/keys/zhyie/id_ed25519.pub")
      (inputs.secrets + "/keys/zhyie/zhyie_elitenix.pub")
    ];
  };
}
