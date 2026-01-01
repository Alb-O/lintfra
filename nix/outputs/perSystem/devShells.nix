# Lintfra devshell using fragment composition
{ pkgs, self', imp, ... }:
let
  shellHookFragments = imp.fragments ./shellHook.d;
  packageFragments = imp.fragmentsWith { inherit pkgs self'; } ./packages.d;
in
{
  default = pkgs.mkShell {
    packages = packageFragments.asList ++ [ self'.formatter ];
    shellHook = ''
      ${shellHookFragments.asString}
      echo ""
      echo "lintfra devshell"
    '';
  };
}
