# Using Ansible to create a working app that communicates with a database

- A repo showcasing how to use Ansible to deploy an app

- This makes use of three EC2 instances (or nodes) where one node (the controller) will automate the task of preparing the other two nodes

- A massive benefit that Ansible gives us is that we no longer need to SSH into a machine and manually set up the environment
    - It follows that the instructions in the following relate solely to the control node

<br>

## Pre-requisites
- Have three fresh EC2 instances
    - These instances must be on the same VPC because the files in this repository make use of private IPv4 address as opposed to public ones

<br>

## How to use
- You will need to have three EC2 instances up:
    1. The Ansible controller
    2. An app instance
    3. A database instance

> Try to ensure that you configure the security groups correctly (i.e. allow the control node SSH access into the other two instances etc.)

> Also ensure that the AWS key you use to SSH into the control node is the same one for the other two instances as while not strictly necessary, it will be much more convenient

<br>

**Step-by-step**
1. The first step is to SSH into your controller node

2. Then navigate to the home directory via `cd ~`
    - Note: If `ubuntu` is not the user you have logged into this path will not work. In such a case you will have to `cd /home/ubuntu` instead
    - In the following, the home directory will refer to the home directory of the `ubuntu` user

3. You will need to clone this repo there
    - Do so with the command `git clone https://github.com/jaredsparta/Ansible-1.git`

4. Then navigate to `setup-files`
    - You can do so with `cd ~/Ansible-1/setup-files`

5. Run `install-ansible.sh`
    - The file in the repo is not an executable so run it with `bash install-ansible.sh`

6. You will need a copy of the AWS key(s) used to SSH into the app and database instances
    - Find them in your local machine and `scp` them into the controller node
    - Copy them into the `~/.ssh` directory in the controller
    
7. Once the key(s) is inside `.ssh` you will need to change permissions as it is currently too open
    - Run the command `sudo chmod 600 <key-file>` to do so

8. You will now need to change the `hosts` file to reflect your own instances
    - Change the app and database IP addresses to the ones you have
    - You will also need to change the SSH key path at the bottom to the one you have
    - If each instance has a different key then the hosts file should look like this;
    ```yaml
    all:
      hosts:
        db_server:
          ansible_host: 172.31.40.107
          ansible_ssh_private_key_file: <path-to-file>

        app_server:
          ansible_host: 172.31.34.77
          ansible_ssh_private_key_file: <path-to-file>
    ```

9. Setup is now complete and we can move onto running playbooks. Navigate to `Ansible-1/ansible-playbooks`
    - This can be done via `cd ~/Ansible-1/ansible-playbooks`

10. Run the `both.yaml` playbook to prepare both
    - Use the command `ansible-playbook both.yaml`
    - If you just want to run a single playbook you can use `ansible-playbook <name-of-playbook>`

<br>

**Optional**

- **Only do the following once you have completed the first 8 steps**

- If you would like to use separate keys for Ansible, go into `~/.ssh` inside your control node and run the command `ssh-keygen`.
    - This will create two new files called `id_rsa` and `id_rsa.pub` if no name is given, otherwise they will be called `<name>` and `<name>.pub` 

- We will now need to add the public key to the list of authorised keys in the app and database nodes

- Once the keys have been created, you can run `change-ssh-keys.yaml` within `setup-files`
    - Ensure you input the `.pub` key, NOT the private key
    - Run it via `ansible-playbook change-ssh-keys.yaml`

- Finally, you will need to once again change the `hosts` file
    - Change the key file in `vars` to the private key of the key you have just made
    - The private key will have the same name as the public key but without the extension `.pub`

> Notice how you will need the AWS key regardless of whether or not you wish to have separate keys for Ansible to use, so ensure you have it ready
