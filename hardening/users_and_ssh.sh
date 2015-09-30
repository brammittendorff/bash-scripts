#! /bin/bash

echo "Change root password and remember it"
passwd root

echo "Add a main sudo user"
read SUDO_USER
adduser $SUDO_USER
adduser $SUDO_USER sudo

echo "Add a connecting user"
read CON_USER
adduser $CON_USER

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i -e '/PermitRootLogin/ s/yes/no/' /etc/ssh/sshd_config
sudo sed -i '/^#.* PasswordAuthentication /s/^#//' /etc/ssh/sshd_config
sudo sed -i -e '/PasswordAuthentication/ s/yes/no/' /etc/ssh/sshd_config

echo "Add a public trusted key for the connecting user"
read KEY

mkdir -p /home/$CON_USER/.ssh
echo $KEY >> /home/$CON_USER/.ssh/authorized_keys
chown -R $CON_USER:$CON_USER /home/$CON_USER

sudo service ssh reload

