# lintfra

Shared linting infrastructure injected into projects via imp.gits.

## Integration

Lintfra files are synced into target projects under `nix/outputs/perSystem/` and `lint/`.

imp.lib auto-merges `packages.d/` into `self'.packages`:
- `packages.d/10-lint.nix` provides `self'.packages.lint`

Other `.d` directories are consumed via `imp.fragments`:
- `shell-packages.d/` - devshell package lists
- `shellHook.d/` - shell script fragments

No manual configuration needed - just sync the files and it works.

## Files Provided

- `packages.d/10-lint.nix` - lint package (auto-merged into `self'.packages`)
- `shell-packages.d/10-lintfra.nix` - devshell packages (list, via `imp.fragmentsWith`)
- `shellHook.d/10-lintfra.sh` - pre-commit hook setup (via `imp.fragments`)
- `nix/scripts/lint-runner` - unified ast-grep + custom rules runner
- `nix/scripts/pre-commit` - git hook
- `lint/` - ast-grep rules and custom rule definitions

## Directory Conventions

imp.lib auto-merges only known flake output `.d` directories:
- `packages.d/`, `devShells.d/`, `checks.d/`, `apps.d/`, etc.

Other `.d` directories are for manual fragment collection:
- `shell-packages.d/` - list fragments for devshell packages
- `shellHook.d/` - shell script fragments for shellHook
