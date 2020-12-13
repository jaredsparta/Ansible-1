# Use this to install Ansible

sudo apt update
sudo apt install software-properties-common -yes
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

# Will rename the default hosts file to hosts.default and set a symlink to the one in our repo
sudo mv /etc/ansible/hosts /etc/ansible/hosts.default
sudo ln -s /home/ubuntu/Ansible-1/setup-files/hosts /etc/ansible/hosts
