{
  inputs,
  lib,
  stdenv,
  writeShellScriptBin,
}:

let
  inherit (inputs.self.checks.${stdenv.hostPlatform.system}.git-hooks) config;
in
writeShellScriptBin "git-hooks" ''
  ${lib.getExe config.package} run --all-files --config ${config.configFile}
''
