#! /bin/bash

echo -n "Change root password and remember it: "
passwd root

echo -n "Add a main sudo user [dummy]: "
read SUDO_USER
SUDO_USER=${SUDO_USER:-dummy}
adduser $SUDO_USER
adduser $SUDO_USER sudo

echo -n "Add a connecting user [test]: "
read CON_USER
CON_USER=${CON_USER:-test}
adduser $CON_USER

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i -e '/PermitRootLogin/ s/yes/no/' /etc/ssh/sshd_config
sudo sed -i '/^#.* PasswordAuthentication /s/^#//' /etc/ssh/sshd_config
sudo sed -i -e '/PasswordAuthentication/ s/yes/no/' /etc/ssh/sshd_config

echo -n "Add a public trusted key for the connecting user: "
read KEY

mkdir -p /home/$CON_USER/.ssh
echo $KEY >> /home/$CON_USER/.ssh/authorized_keys
chown -R $CON_USER:$CON_USER /home/$CON_USER

sudo service ssh reload
