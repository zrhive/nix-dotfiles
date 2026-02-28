{ ... }:

{
  users.users.zhyie = {
    description = "zhyie is the baddest of all.";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ];
  }
}
