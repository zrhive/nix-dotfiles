{ ... }@args:

rec {
  host = import ./host args;
  platform = import ./platform.nix args;

  inherit (host)
    callHost
    homeModule
    homeDefault
    mkNixos
    mkDarwin
    mkDroid
    mkHome
    ;
  inherit (platform)
    filterNixos
    filterDarwin
    filterWsl
    filterDroid
    isLinux
    isDarwin
    systemList
    eachSystem
    ;
}
