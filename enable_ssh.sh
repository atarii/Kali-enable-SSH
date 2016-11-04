#!/usr/bin/env bash

# Kudos to Alakhani, commands extracted from http://www.drchaos.com/enable-ssh-on-kali-linux-enable-ssh-on-kali-linux/

echo "[*] Resetting SSH service run levels to default"
update-rc.d -f ssh remove
update-rc.d -f ssh defaults

echo "[*] Backing up default Kali keys"
cd /etc/ssh/
mkdir insecure_original_default_kali_keys
mv ssh_host_* insecure_original_default_kali_keys/ 

echo "[*] Generating new keys"
dpkg-reconfigure openssh-server

echo "[*] Permitting root login"
sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/" /etc/ssh/sshd_config

echo "[*] Restarting SSH service"
service ssh restart
update-rc.d -f ssh enable 2 3 4 5
