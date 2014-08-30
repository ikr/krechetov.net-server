/etc/ssl/certs/mail_ikr_su.pem:
  file.exists

/etc/ssl/private/mail_ikr_su.key:
  file.exists

mail-packages:
  pkg.installed:
    - pkgs:
      - postfix
      - dovecot-core
      - dovecot-imapd
    - require:
      - file: /etc/ssl/certs/mail_ikr_su.pem
      - file: /etc/ssl/private/mail_ikr_su.key

/etc/mailname:
  file.managed:
    - source: salt://mail/mailname
    - require:
      - pkg: mail-packages

/etc/aliases:
  file.managed:
    - source: salt://mail/aliases
    - require:
      - pkg: mail-packages

newaliases:
  cmd.wait:
    - watch:
      - file: /etc/aliases

/etc/postfix/master.cf:
  file.managed:
    - source: salt://mail/master.cf
    - require:
      - pkg: mail-packages

/etc/postfix/main.cf:
  file.managed:
    - source: salt://mail/main.cf
    - require:
      - pkg: mail-packages
