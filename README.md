# <div align="center">☁️ vps-setup</div>

<div align="center">
    <kbd>
        <a href="https://github.com/mlops-top/vps-setup/actions/workflows/ci.yml" target="_blank"><img src="https://github.com/mlops-top/vps-setup/actions/workflows/ci.yml/badge.svg" alt="build status"></a>
        <a href="https://github.com/mlops-top/vps-setup/blob/main/LICENSE" target="_blank"><img src="https://img.shields.io/github/license/mlops-top/vps-setup" alt="license"></a>
    </kbd>
</div>

## Overview

Setting up a virtual private server.\
The provisioning and hardening are automated using Ansible.

This repository was inspired by the following videos:

- [10 Tips for Hardening your Linux Servers](https://youtu.be/Jnxx_IAC0G4?si=xUs_2m8IjDTGYxl7)
- [Setting up a production ready VPS](https://youtu.be/F-9KWQByeU0?si=v7OE4IBhpqrzaD1R)

## Pre-requisites

The following tools are needed to reproduce the setup:

- [1Password CLI](https://developer.1password.com/docs/cli/get-started) for secret management
- [Just](https://github.com/casey/just) for running commands
- [Uv](https://docs.astral.sh/uv) for managing python packages like [Ansible](https://docs.ansible.com)
- [Tailscale](https://tailscale.com) for secure networking
- [Netdata](https://www.netdata.cloud) for resource monitoring
- And a VPS running Ubuntu 26.04

> [!NOTE]
> The solutions use 1Password's CLI to retrieve sensitive data.\
> The secret references in `.env.op` must be updated. [More information here.](https://developer.1password.com/docs/cli/secret-references)
> See `.env.op.example` for the expected variables.

## Python Virtual Environment

After cloning the repository create a python virtual environment and install the requirements:

```bash
just install
```

## VPS Setup

If you are me, and have access to the private overlay repository, initialize it and restore the local symlinks with:

```bash
just setup-vps-setup-private
```

For a standalone setup, create and populate the files manually from the examples:

```bash
cp .env.op.example .env.op
cp ansible/inventory.example.ini ansible/inventory.initial.ini
cp ansible/inventory.example.ini ansible/inventory.provision.ini
```

The initial run connects over the public ip as `root`, while the provision run connects over the tailscale ip as `ansible`.\
Update the `ansible_host`, `ansible_user` and `ansible_ssh_private_key_file` variables in each file accordingly.

Consider also setting the system `hostname` at the vps provider's panel so that tailscale can use it.

The `vps-setup` playbook can be run with the following command:

```bash
just ansible-initial
```

It is recommended to reboot the machine after the playbook has finished running.

For later runs call:

```bash
just ansible-provision
```

<hr>

<div align="center">
    <strong>⭐ Star the repository if you found it useful ⭐</strong>
    <br>
    <a href="https://github.com/daniel-mizsak/repository-template" target="_blank">Repository Template</a> |
    <a href="https://github.com/daniel-mizsak/workflows" target="_blank">Reusable Workflows</a> |
    <a href="https://github.com/daniel-mizsak/mtjd" target="_blank">Development Environment </a>
</div>
