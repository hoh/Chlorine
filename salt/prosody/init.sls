
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


/etc/prosody/prosody.cfg.lua:
    file.managed:
        - source: salt://prosody/prosody.cfg.lua
        - template: jinja
        - context:
            hostname: chat.okso.be
