# Playbooks

- Playbooks are YAML files that Ansible uses to prepare servers remotely using SSH

- They are:
    1. Declarative (you don't need any knowledge of the server, only the desired state of it)
    2. Idempotent -- Ansible modules will not change anything that is already in the desired state
    3. Reusable -- we can run the playbook however many times we want and it will always be in the state we want (since modules are idempotent)

<br>

## How to use
- Go into your Ansible controller and create `.yaml` (or `.yml`, depending on your inclination of file extensions) files and copy+paste the contents of these into them
    - Otherwise, just follow the instructions found in the README in the root

- You can run Ansible playbooks with the command `ansible-playbook <name-of-playbook>`

<br>

## How to change the playbooks
- Notice that `both.yaml` only uses the `import` keywords, in this case you will only ever need to change the app or database playbook