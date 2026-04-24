{ ... }:
{
  programs.keychain = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;

    keys = [
      "id_ed25519"
    ];
  };
}
