
fail2ban:
    pkg.installed

unattended-upgrades:
    pkg.installed

/etc/apt/apt.conf.d/10periodic:
    file.append:
        - text: "APT::Periodic::Unattended-Upgrade \"1\";"

