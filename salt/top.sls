# Customize this file with the states you want to be installed

base:
    '*':
        - security
    'mailserver':
        - users
        - opensmtpd
        - dovecot
    'calcardserver':
        - radicale
    'chatserver':
        - prosody
    'gitserver':
        - git-remote
        #- taskd
