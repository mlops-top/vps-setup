# Tools

## Renovate

[Renovate](https://github.com/renovatebot/renovate) is used to keep dependencies like GitHub Actions, pre-commit hooks (or language packages) up to date.\
It is configured in the `.github/renovate.json5` file and requires Renovate to be enabled for the repository or organization.

## Just

[Just](https://github.com/casey/just) is a command runner that helps with invoking commands in a consistent and more concise way.\
It is configured in the `justfile` file.

## Megalinter

[Megalinter](https://github.com/oxsecurity/megalinter) is used to ensure code quality and consistency.\
It is configured in the `.github/linters/.megalinter.yml` file.

## Prek

[Prek](https://prek.j178.dev) is used to run certain checks on the code before it is committed.\
These checks are defined in the `.pre-commit-config.yaml` file.
