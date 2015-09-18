
apt-transport-https:
    pkg.installed

prosody:
    pkgrepo.managed:
        - humanname: Prosody
        - name:  deb http://packages.prosody.im/debian vivid main
        - file: /etc/apt/sources.list.d/prosody.list
        - key_url: salt://prosody/prosody-debian-packages.key
        - require:
            - pkg: apt-transport-https

    pkg.installed:
        - require:
            - pkgrepo: prosody

    service.running:
        - require:
            - pkg: prosody
        - watch:
            - file: /etc/prosody/prosody.cfg.lua
            - file: /etc/ssl/private/device.key
            - file: /etc/ssl/private/device.crt


/etc/prosody/prosody.cfg.lua:
    file.managed:
        - source: salt://prosody/prosody.cfg.lua
        - template: jinja
        - context:
            hostname: chat.okso.be

/etc/ssl/private/device.key:
    file.managed:
        - source: salt://certificates/device.key
        - user: prosody
        - group: root
        - mode: 600

/etc/ssl/private/device.crt:
    file.managed:
        - source: salt://certificates/device.crt
        - user: prosody
        - group: root
        - mode: 600
