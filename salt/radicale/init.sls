virtualenv:
    pkg.installed:
        - names:
            - python-pip
            - virtualenv

/var/lib/radicale:
    file.directory:
        - user: okso

/var/lib/radicale/venv:
    virtualenv.managed:
        - system_site_packages: False
        - user: okso
        - require:
            - pkg: virtualenv
            - file: /var/lib/radicale

pip:
    pip.installed:
        - user: okso
        - bin_env: /var/lib/radicale/venv
        - upgrade: True
        - require:
            - virtualenv: /var/lib/radicale/venv

radicale:
    pip.installed:
        - user: okso
        - bin_env: /var/lib/radicale/venv
        - require:
            - pip: pip

/etc/radicale:
    file.directory:
        - user: root
        - group: root

/etc/radicale/config:
    file.managed:
        - source: salt://radicale/config
        - user: root
        - group: root

/etc/radicale/users:
    file.managed:
        - source: salt://radicale/users
        - user: root
        - group: root

/var/lib/radicale/device.key:
    file.managed:
        - source: salt://certificates/device.key
        - user: okso
        - group: okso
        - mode: 600

/var/lib/radicale/device.crt:
    file.managed:
        - source: salt://certificates/device.crt
        - user: okso
        - group: okso
        - mode: 600
