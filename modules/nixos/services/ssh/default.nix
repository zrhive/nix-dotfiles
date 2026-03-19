{ userList, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 7238 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = userList;
    };
    #
    # hostKeys = [
    #   {
    #     path = "/etc/ssh/ssh_host_ed25519_key";
    #     type = "ed25519";
    #   }
    # ];
    #
    # environment.persistence."/persist".files = [
    #   "/etc/ssh/ssh_host_ed25519_key"
    #   "/etc/ssh/ssh_host_ed25519_key.pub"
    # ];
  };
}
