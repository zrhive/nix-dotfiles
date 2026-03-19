{ pkgs, inputs, ... }:
{
  users.users.zhyie = {
    extraGroups = [
      "wheel"
      "audio"
      "video"
    ];
    shell = pkgs.nushell;
    openssh.authorizedKeys.keyFiles = [
      (inputs.secrets + "/keys/zhyie/id_ed25519.pub")
    ];
  };
}
