
dovecot-imapd:
    pkg.installed:
        - name: dovecot-imapd
    service.running:
        - name: dovecot
        - watch:
            - file: /etc/dovecot/dovecot.conf

/etc/dovecot/dovecot.conf:
    file.managed:
        - source: salt://dovecot/dovecot.conf
        - user: root
        - group: root
        - mode: 644

        - template: jinja
        - defaults:
            ssl_key: '/etc/ssl/private/mail.example.org.key'
            ssl_cert: '/etc/ssl/certs/mail.example.org.crt'
#        - context:
#            ssl_key:
#            ssl_cert:
