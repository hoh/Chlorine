#!/bin/bash

# --- Ubuntu ---

# Install wget if it is missing, such as in LXC Ubuntu templates:

dpkg -s wget 2>/dev/null >/dev/null || apt-get update && sudo apt-get -y install wget


# Install the Salt Stack PPA repo and salt-minion:

echo deb http://ppa.launchpad.net/saltstack/salt/ubuntu `lsb_release -sc` main | tee /etc/apt/sources.list.d/saltstack.list
wget -q -O- "http://keyserver.ubuntu.com:11371/pks/lookup?op=get&search=0x4759FA960E27C0A6" | sudo apt-key add -

apt-get update
apt-get install salt-minion
