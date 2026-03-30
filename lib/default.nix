{ ... }@args:

args.inputs.nixpkgs.lib.makeExtensible (
  self:
  let
    callLibs =
      file:
      import file (
        args
        // {
          inherit self;
          inherit (args.inputs.nixpkgs) lib;
        }
      );
  in
  {
    host = callLibs ./host;
    platform = callLibs ./platform.nix;

    inherit (self.host)
      # mkNixos
      # mkDarwin
      mkHost
      mkHome
      ;
    inherit (self.platform)
      isLinux
      isDarwin
      ;
  }
)
