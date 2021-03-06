ruby_packages:
  pkg.installed:
    - pkgs:
      - ruby
      - ruby-dev
      - make
      - gcc
      - g++

nodejs:
  pkg.installed

jekyll:
  gem.installed:
    - require:
      - pkg: ruby_packages

/var/www/ikr.su-blog:
  file.directory:
    - user: ikr
    - group: users
    - dir_mode: 755
    - require:
      - file: /var/www

https://github.com/ikr/ikr.su-blog.git:
  git.latest:
    - rev: master
    - target: /var/www/ikr.su-blog
    - user: ikr
    - require:
      - file: /var/www/ikr.su-blog

jekyll_build:
  cmd.wait:
    - name: jekyll build
    - cwd: /var/www/ikr.su-blog
    - runas: ikr
    - watch:
      - git: https://github.com/ikr/ikr.su-blog.git
    - require:
      - pkg: nodejs
      - gem: jekyll
      - file: /var/www/ikr.su-blog

/var/www/heap:
  file.directory:
    - user: ikr
    - group: users
    - dir_mode: 755
    - require:
      - file: /var/www

/var/www:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755

/var/www/ikr.su:
  file.directory:
    - user: ikr
    - group: users
    - dir_mode: 755
    - require:
      - file: /var/www

https://github.com/ikr/ikr.su.git:
  git.latest:
    - rev: master
    - target: /var/www/ikr.su
    - user: ikr
    - require:
      - file: /var/www/ikr.su
