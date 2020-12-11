# Using Ansible to create a working app that communicates with a database

## Pre-requisites
- You will need a macOS or a Linux distribution to be able to use Ansible -- it will not work on a Windows OS
    - In such a case you can use a VM

<br>

## How to use
- First you will need to have a machine that will be the controller -- i.e. the control node for Ansible
    - This node will be the one containing playbooks that will be used to provision our app and database machines

- You will need to clone this repo to be able to use these files and playbooks too

- Once done, you will need two extra machines:
    1. One to host our app
    2. Another to host a database to communicate with the app

- Before using the playbooks, you will need to set the hosts up
    - You can do this through changing `/etc/ansible/hosts`
    - Inside this file you will need to define the relevant IP addresses for your app and database
    