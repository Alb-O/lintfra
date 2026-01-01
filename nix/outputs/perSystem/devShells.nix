# Lintfra devshell - uses inputsFrom to compose with lintfra shell
{ pkgs, self', ... }:
{
  default = pkgs.mkShell {
    inputsFrom = [ self'.devShells.lintfra ];
    packages = [ self'.formatter ];
    shellHook = ''
      echo ""
      echo "lintfra devshell"
    '';
  };
}
