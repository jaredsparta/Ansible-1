# Task 1
```
Tiny exercise using Adhock commands:

    1. check the uptime of a machine

    2. Find the ansible terminology to Updating and upgrading all packages

```

1. `ansible all -m command -a uptime`

2. `ansible host_a_public -m apt -a "upgrade=yes" --become`