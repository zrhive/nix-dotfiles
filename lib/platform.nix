{ lib }:
{
  isLinux = p: f: lib.mkIf (lib.hasSuffix "linux" p) f;
  isDarwin = p: f: lib.mkIf (lib.hasSuffix "darwin" p) f;
}
