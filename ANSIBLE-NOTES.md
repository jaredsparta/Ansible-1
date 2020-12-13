# Ansible

**CONTENTS**
1. Inventories
2. Pinging hosts
3. Ad-hoc commands
4. Playbooks
5. Templates

<br>

## Host file or Inventory
- The default Inventory file is found within `/etc/ansible/hosts` in an Ubuntu server

- Here you specify the hosts (within groups if wanted) and how to connect to them

- The following is an example of a file using INI
```INI
[app_server]
192.168.10.100 ansible_connection=ssh ansible_ssh_private_key_file=/home/ubuntu/.ssh/eng74Jaredawskey.pem

[db_server]
192.168.10.200 ansible_connection=ssh ansible_ssh_private_key_file=/home/ubuntu/.ssh/eng74Jaredawskey.pem
```

<br>

- This is the same file written in YAML. Notice how there are repetitions.

```yaml
all:
  hosts:
    example.example.example.com

  children:
    app_server:
      ansible_host: 192.168.10.100
      ansible_connection: ssh
      ansible_ssh_private_key_file: /home/ubuntu/.ssh/eng74Jaredawskey.pem

    db_server:
      ansible_host: 192.168.10.200
      ansible_connection: ssh
      ansible_ssh_private_key_file: /home/ubuntu/.ssh/eng74Jaredawskey.pem
```

<br>

- Again, this is the same file but written more efficiently. We can do this because these inventory variables apply to all the groups.
```yaml
all:
  hosts:
    example.example.example.com

  children:
    app_server:
      ansible_host: 192.168.10.100

    db_server:
      ansible_host: 192.168.10.200

  vars:
    ansible_connection: ssh
    ansible_ssh_private_key_file: /home/ubuntu/.ssh/eng74Jaredawskey.pem
```

<br>

- What about the syntax when there are two or more ips in a group?

```yaml
all:
  hosts:
      db_server:
        ansible_host: 172.31.40.107
        ansible_host: 123.11.111.11
  vars:
    ansible_connection: ssh
    ansible_ssh_private_key_file: /home/ubuntu/.ssh/eng74Jaredawskey.pem
```

<br>

## Pinging a host
```bash
ansible all -m ping # pings all hosts
ansible host_a -m ping # pings hosts within the group host_a
```

<br>

## Ad-hoc commands
- While playbooks are good as they allow you to repeat tasks, ad-hoc commands are useful for tasks that you will rarely ever do
  - Examples could be to turning off all the machines in an area
  - Copy over some files once, and only once etc.

- They achieve a form of idempotence by checking the current state before they begin and doing nothing unless the current state is different from the specified final state

- An ad-hoc command looks like:
```yaml
$ ansible [pattern] -m [module] -a "[module options]"
```

- The Ansible way of running bash commands as sudo is with the `--become` keyword
```yaml
$ ansible all -a "apt-get update" --become
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

<br>

## Templates and Variables
- `template` is another Ansible module that uses the Jinja2 templating language

- A Jinja template is simply a text file which can be generated in formats such as HTML, XML, CSV etc.

- We will be able to interpolate (substitute) variables into them, making them dynamic.

<br>

**How do you use variables in Ansible?**
- There are a couple of ways of doing so:
  1. You can capture the STDOUT of a task and use the `register` keyword to assign that output to a variable
  2. We can have a file containing variables and we indicate the path of it
  3. We can define variables within a job, on the same level as `hosts`


- Substitutions are used with `{% %}`or `{{}}`
    - `{% %}` are used for functions
    - `{{}}` are used for variables

<br>

**Using variables**
```yaml
- hosts: all
  remote_user: root

  vars:
    app-IP:
      public: 192.168.10.100
      private: 192.168.10.200
```
- Here, we create a variable dictionary `app-IP`. To reference the public IP or private IP we can call this variable using `{{ app-IP["public"] }}