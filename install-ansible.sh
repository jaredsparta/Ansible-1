# Use this to install Ansible

sudo apt update
sudo apt install software-properties-common -yes
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

sudo mv /etc/ansible/hosts /etc/ansible/hosts.backup