{
  self,
  inputs,
  hosts,
  ...
}:
{
  isLinux = p: f: if (self.hasSuffix "linux" p) then f else null;
  isDarwin = p: f: if (self.hasSuffix "darwin" p) then f else null;

  systemList = self.unique (self.attrValues (self.mapAttrs (_: h: h.system) hosts));
  eachSystem = f: self.genAttrs self.systemList (system: f inputs.nixpkgs.legacyPackages.${system});
}
