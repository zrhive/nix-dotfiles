{ ... } @ xinherits:

{
  mkHost = host: cfg: import ./mkHost.nix (xinherits // {
    inherit host;
    inherit (cfg) system userList moduleList stateVersion;
  });
}
