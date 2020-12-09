# Ansible

- It's a configuration tool 

## Host file
- Here you specify the hosts (within groups if wanted) and how to connect to them
```yaml
[host_a]
3.249.253.143 ansible_connection=ssh ansible_ssh_private_key_file=/home/ubuntu/.ssh/eng74Jaredawskey.pem

[host_b]
172.31.47.217 ansible_connection=ssh ansible_ssh_private_key_file=/home/ubuntu/.ssh/eng74Jaredawskey.pem
```

## Pinging a host
```bash
ansible all -m ping # pings all hosts
ansible host_a -m ping # pings hosts within the group host_a
```