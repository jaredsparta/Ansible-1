# Playbooks

- Playbooks are YAML files that Ansible uses to prepare servers remotely using SSH

- They are:
    1. Declarative (you don't need any knowledge of the server, only the desired state of it)
    2. Idempotent -- Ansible modules will not change anything that is already in the desired state
    3. Reusable -- we can run the playbook however many times we want and it will always be in the state we want (since modules are idempotent)

<br>

## How to use
- Go into your Ansible controller and create `.yaml` files and copy+paste the contents of these into them
- Of course you will have to change the corresponding IPs