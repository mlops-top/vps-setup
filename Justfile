@_:
    just --list --unsorted

vps-setup-private-directory := "vps-setup-private"

[group("lifecycle")]
setup-vps-setup-private:
    # First: `git submodule add --force --branch main git@github.com:mlops-top/vps-setup-private.git vps-setup-private`
    git submodule update --init --remote {{ vps-setup-private-directory }}
    ln -sfn {{ vps-setup-private-directory }}/.env.op .env.op
    ln -sfn ../{{ vps-setup-private-directory }}/ansible/inventory.initial.ini ansible/inventory.initial.ini
    ln -sfn ../{{ vps-setup-private-directory }}/ansible/inventory.provision.ini ansible/inventory.provision.ini

[group("lifecycle")]
clean:
    rm -rf \
        .ansible \
        megalinter-reports \
        .venv
    find . -type f -name ".DS_Store" -delete

[group("lifecycle")]
install *args:
    uv sync --all-groups {{ args }}

[group("lifecycle")]
upgrade:
    just install --upgrade

[group("lifecycle")]
[working-directory("ansible")]
upgrade-ansible:
    uv run ansible-galaxy collection install --requirements-file requirements.yml --upgrade

[group("lifecycle")]
fresh: clean install

[group("qa")]
lint-yaml:
    uv run yamllint --config-file .github/linters/.yamllint.yml --strict .

[group("qa")]
[working-directory("ansible")]
lint-ansible:
    uv run ansible-lint --config-file ../.github/linters/.ansible-lint.yml

[group("qa")]
[working-directory("ansible")]
test:
    uv run molecule test

[group("qa")]
check-all: lint-yaml lint-ansible test

[group("qa-extra")]
megalinter:
    just clean
    npx mega-linter-runner --flavor cupcake --env "MEGALINTER_CONFIG=.github/linters/.megalinter.yml"
    just install

[group("qa-extra")]
prek:
    uv run prek run --all-files

[confirm("Run ansible initial? (y/N)")]
[group("run")]
[working-directory("ansible")]
ansible-initial:
    op run --env-file="../.env.op" --no-masking -- uv run ansible-playbook --inventory inventory.initial.ini playbook.yml

[confirm("Run ansible provision? (y/N)")]
[group("run")]
[working-directory("ansible")]
ansible-provision:
    op run --env-file="../.env.op" --no-masking -- uv run ansible-playbook --inventory inventory.provision.ini playbook.yml
