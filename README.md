# Ansible

- It's a configuration tool 

<br>

## Host file
- Here you specify the hosts (within groups if wanted) and how to connect to them
```yaml
[host_a]
3.249.253.143 ansible_connection=ssh ansible_ssh_private_key_file=/home/ubuntu/.ssh/eng74Jaredawskey.pem

[host_b]
172.31.47.217 ansible_connection=ssh ansible_ssh_private_key_file=/home/ubuntu/.ssh/eng74Jaredawskey.pem
```

<br>

## Pinging a host
```bash
ansible all -m ping # pings all hosts
ansible host_a -m ping # pings hosts within the group host_a
```

<br>

## Running commands with sudo with ansible
- The Ansible way of running bash commands as sudo is with the `--become` keyword
```yaml
ansible all -a "apt-get update" --become
```

<br>

## Playbooks
- Playbooks are written in YAML
- The file starts after three dashes `---`
- Indentation matters
- To run commands use `ansible-playbook <name>`

**Example:**
```yaml
# This is going to be our example Playbook which is written in YAML
# Your YAML playbook file starts after three dashes

---
# This example targets host_a_public

- name: install sql # can be anything
  hosts: host_a_public # specify a host or host group
  gather_facts: yes # gathers facts/states of machine before running the playbook
  become: true # become is used to run the commands as sudo

  tasks:
  - name: Install SQL DB
    apt: pkg=mysql-server state=present
```



