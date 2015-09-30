
git:
    pkg.installed:
        - name: git

    user.present:
        - shell: "/usr/bin/git-shell"       
        - require:
            - pkg: git

openssh-server:
    pkg.installed:
        - name: openssh-server

    service.running:
        - name: ssh
    

/home/git/.ssh:
    file.directory:
        - user: git
        - group: git
        - mode: 700

/home/git/.ssh/authorized_keys:
    file.managed:
        - user: git
        - group: git
        - mode: 400
        - source: salt://git-remote/authorized_keys
        - require:
            - file: /home/git/.ssh

/home/git/git-shell-commands:
    file.directory:
        - user: root
        - group: root
        - mode: 755

#/home/git/git-shell-commands/no-interactive-login:
#    file.managed:
#        - user: root
#        - group: root
#        - mode: 755
#        - source: salt://git-remote/no-interactive-login

