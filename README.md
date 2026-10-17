# ansible-web

Ansible project that configures two Debian web servers.

- web1 runs nginx through the `nginx` role
- web2 runs Apache through the `apache` role

## Usage

```bash
ansible-galaxy collection install -r collections/requirements.yml
ansible-playbook bootstrap.yml -K
ansible-playbook site.yml
```

## Quality

```bash
ansible-lint
```
