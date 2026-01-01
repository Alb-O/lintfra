# lintfra

Rust + Nix linting infrastructure using ast-grep.

## Usage

```bash
nix develop  # enter devshell, installs pre-commit hook
lint         # run all lints
lint --json  # JSON output
```

## Rules

**lint/ast-rules/** (ast-grep)
- `allow-attribute-reason` - require reason on #[allow(...)]
- `no-decorative-headings` - no `// ====` style comments
- `no-short-comments` - flag trivial comments (<25 chars)

**lint/custom-rules/** (lint-runner)
- `clippy` - runs cargo clippy
- `file-too-long` - flag files >450 lines

## Scripts

- `nix/scripts/lint-runner` - unified runner for ast-grep + custom rules
- `nix/scripts/pre-commit` - hook that runs lint + treefmt on staged files

## Nix

- `devShells.default` - provides `lint` command, installs pre-commit hook
- `checks.formatting` - treefmt via imp-fmt
- `checks.ast-grep-scan` - runs ast-grep scan
