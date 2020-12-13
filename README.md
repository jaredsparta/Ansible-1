# Using Ansible to create a working app that communicates with a database

- A repo showcasing how to use Ansible to deploy an app

- This makes use of three EC2 instances (or nodes) where one node (the controller) will automate the task of preparing the other two nodes

- A massive benefit that Ansible gives us is that we no longer need to SSH into a machine and manually set up the environment
    - It follows that the instructions in the following relate purely to the control node

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

- As mentioned, you will only need to work with the control node. In such a case, you will need to first SSH into your controller instance

- You will need to clone this repo to be able to use these files 
    1. Inside your controller, `cd` to the home directory and clone this repo there
    2. Run the shell script `install-ansible.sh` with the command `bash install-ansible.sh`
    > The file can be found in `setup-files`
    3. You will need to `scp` your AWS key file into this machine too. Put the key into `~/.ssh`. The key must be the same one thet can be used to SSH into the two other instances.

> The paths inside the playbooks will only work if you `git clone` when in the home directory

- Finally, you will need to change three things found in `setup-files/hosts`
    1. Switch the IP address of `db_server` to your one
    2. Switch the IP address of `app_server` to your one
    3. Switch the path of the AWS key to your one

> The `hosts` file will need to be appended to reflect the IP's of your app and database as well as the relevant AWS key. You will only need to change the IP's found in the `hosts` file.

- You are now ready to run the playbooks. Navigate to `ansible-playbooks` to do so
    - You can run it via `ansible-playbook both.yaml`
    - If you would like to change the behaviour of some of the commands, you can do so by changing the relevant playbooks `app_playbook.yaml` or `db_playbook.yaml`

<br>

**Optional**

- **Only do the following once the previous steps have been done**

- If you would like to use separate keys for Ansible, go into `~/.ssh` inside your control node and run the command `ssh-keygen`.
    - This will create two new files called `id_rsa` and `id_rsa.pub` if no name is given, otherwise they will be called `<name>` and `<name>.pub` 

- You will now need to use the AWS key you have
    - What we need to do is give the public key we have just generated to each of the instances. We do this by adding the contents of the `.pub` file as a line into the `~/.ssh/authorized_keys` file found in both instances

- Once the key has been created, you can run `change-ssh-keys.yaml` within `setup-files`
    - Ensure you input the `.pub` key, NOT the private key
    - Run it via `ansible-playbook change-ssh-keys.yaml`

- Finally, you will need to once again change the `hosts` file
    - Change the key file in `vars` to the private key of the key you have just made

> Notice how you will need the AWS key regardless of whether or not you wish to have separate keys for Ansible to use, so ensure you have it ready
