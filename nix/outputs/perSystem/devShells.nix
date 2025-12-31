{
  __functor =
    _:
    {
      pkgs,
      rootSrc,
      self',
      ...
    }:
    let
      lint-cmd = pkgs.writeShellScriptBin "lint" ''
        if [[ -x ./nix/scripts/lint-runner ]]; then
          exec ./nix/scripts/lint-runner "$@"
        else
          echo "Error: lint-runner not found. Run from project root." >&2
          exit 1
        fi
      '';
    in
    {
      default = pkgs.mkShell {
        packages = [
          pkgs.ast-grep
          pkgs.yq-go
          pkgs.jq
          lint-cmd
          self'.formatter
        ];

        shellHook = ''
          if [ -t 0 ]; then
            # Install pre-commit hook
            if [ -d .git ]; then
              cp ${rootSrc}/nix/scripts/pre-commit .git/hooks/pre-commit
              chmod +x .git/hooks/pre-commit
            fi
          fi

          echo "lintfra devshell"
          echo ""
          echo "Commands:"
          echo "  lint        - Run unified lint (ast-grep + custom rules)"
          echo "  lint --json - Output lint results as JSON stream"
        '';
      };
    };
}
