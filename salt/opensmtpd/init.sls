
mailutils:
    pkg.installed


opensmtpd:
    pkg.installed:
        - name: opensmtpd
    service.running:
        - enable: True
        - name: opensmtpd
        - reload: True
        - watch:
            - file: /etc/smtpd.conf
            - file: /etc/ssl/private/device.key
            - file: /etc/ssl/private/device.crt

/etc/smtpd.conf:
    file.managed:
        - source: salt://opensmtpd/smtpd.conf
        - user: root
        - group: root
        - template: jinja
        - context:
            hostname: mail.okso.be
            domain: okso.be

/etc/ssl/private/device.key:
    file.managed:
        - source: salt://certificates/device.key
        - user: root
        - group: root
        - mode: 600

/etc/ssl/private/device.crt:
    file.managed:
        - source: salt://certificates/device.crt
        - user: root
        - group: root
        - mode: 600
