## <div align="center">☁️ vps-setup</div>
<div align="center">
    <kbd>
        <a href="https://github.com/mlops-top/vps-setup/actions/workflows/ci.yml" target="_blank"><img src="https://github.com/mlops-top/vps-setup/actions/workflows/ci.yml/badge.svg" alt="build status"></a>
        <a href="https://results.pre-commit.ci/latest/github/mlops-top/vps-setup/main" target="_blank"><img src="https://results.pre-commit.ci/badge/github/mlops-top/vps-setup/main.svg" alt="pre-commit.ci status"></a>
        <a href="https://img.shields.io/github/license/mlops-top/vps-setup" target="_blank"><img src="https://img.shields.io/github/license/mlops-top/vps-setup" alt="license"></a>
    </kbd>
</div>


## Overview
This repository was inspired by the following videos:
- [10 Tips for Hardening your Linux Servers](https://youtu.be/Jnxx_IAC0G4?si=xUs_2m8IjDTGYxl7)
- [Setting up a production ready VPS](https://youtu.be/F-9KWQByeU0?si=v7OE4IBhpqrzaD1R)

 The provisioning and hardening are automated using Ansible and Terraform.


## Pre-requisites
The following tools are needed:
- [1Password CLI](https://developer.1password.com/docs/cli/get-started)
- [Python](https://www.python.org/downloads/)
- [Terraform](https://www.terraform.io)
- A [VPS](https://hostinger.com?REFERRALCODE=mlopstop) running Ubuntu


## VPS Setup
After cloning the repository create a python virtual environment and install the requirements:

```bash
python -m venv --upgrade-deps .venv
source .venv/bin/activate
```
```bash
cd ansible
pip install --requirement requirements.txt
```

Copy the example inventory file:

```bash
cp example.inventory.ini inventory.ini
```

In the `inventory.ini` file update the `ansible_host` and `ansible_ssh_private_key_file` variables.\
The playbook assumes that your public SSH key is already added to the root user's `~/.ssh/authorized_keys` file.

> [!NOTE]
> The playbook uses 1Password's CLI to retrieve sensitive data.\
> The secret references in `.env.enc` must be updated. [More information here.](https://developer.1password.com/docs/cli/secret-references/)

The `vps-setup` playbook can be run with the following command:

```bash
op run --env-file="../.env.enc" -- ansible-playbook playbook.yml
```

It is recommended to reboot the machine after the playbook has finished running.\
Since from now on root user is disabled, for further playbook runs set `remote_user` in `playbook.yml` to the system user.


## Backup
The playbook creates a `/backup` directory that syncs its content with an `R2 Cloudflare` bucket.\
Setting up this bucket is done using `Terraform`:

```bash
cd ../terraform
terraform init
```
```bash
op run --env-file="../.env.enc" -- terraform apply
```

<hr>

<div align="center">
    <strong>⭐ Star the repository if you found it useful ⭐</strong>
    <br>
    <a href="https://github.com/daniel-mizsak/repository-template" target="_blank">Repository Template</a> |
    <a href="https://github.com/daniel-mizsak/workflows" target="_blank">Reusable Workflows</a> |
    <a href="https://github.com/daniel-mizsak/mtjd" target="_blank">Development Environment </a>
</div>
