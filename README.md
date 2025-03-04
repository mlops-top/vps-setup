## <div align="center">☁️ vps-setup</div>
<div align="center">
    <kbd>
        <a href="https://github.com/mlops-top/vps-setup/actions/workflows/ci.yml" target="_blank"><img src="https://github.com/daniel-mizsak/vps-setup/actions/workflows/ci.yml/badge.svg" alt="build status"></a>
        <a href="https://results.pre-commit.ci/latest/github/mlops-top/vps-setup/main" target="_blank"><img src="https://results.pre-commit.ci/badge/github/daniel-mizsak/vps-setup/main.svg" alt="pre-commit.ci status"></a>
        <a href="https://img.shields.io/github/license/mlops-top/vps-setup" target="_blank"><img src="https://img.shields.io/github/license/daniel-mizsak/vps-setup" alt="license"></a>
    </kbd>
</div>


## Overview
This repository was inspired by [Learn Linux TV](https://www.youtube.com/@LearnLinuxTV)'s [10 Tips for Hardening your Linux Servers
 ](https://youtu.be/Jnxx_IAC0G4?si=xUs_2m8IjDTGYxl7) and [Dreams of Codes](https://www.youtube.com/@dreamsofcode)'s [Setting up a production ready VPS](https://youtu.be/F-9KWQByeU0?si=v7OE4IBhpqrzaD1R) video.\
 The hardening recommendations are automated using Ansible.


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

Rename the example inventory file and replace the placeholder (`xxxx`) with your VPS's IP address:
```bash
mv example.inventory.ini inventory.ini
```

The playbook assumes that your public SSH key is already added to the root user's `~/.ssh/authorized_keys` file.\
In `ansible.cfg` the default name of the private key is `id_hostinger`. Please update this if your SSH key's name differs.

> [!NOTE]
> The playbook uses 1Password's CLI to retrieve the sudo user's password and the service account token.
> It is recommended to use some sort of encryption when passing sensitive information.

The `vps-setup` playbook can be run with the following command:
```bash
op run --env-file=".env.enc" -- ansible-playbook playbook.yml
```


It is recommended to reboot the machine after the playbook has finished running.
