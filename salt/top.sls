# Customize this file with the states you want to be installed

base:
    'mailserver':
        - users
        - opensmtpd
        - dovecot
    'calcardserver':
        - radicale
    'chatserver':
        - prosody
        #- taskd
