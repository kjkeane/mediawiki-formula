{% from "mediawiki/map.jinja" import mediawiki with context %}
{% set wiki = salt['pillar.get']('mediawiki', {}) %}

mediawiki_packages:
  pkg.installed:
    - pkgs:
      - php71u-cli
      - php71u-common
      - php71u-dba
      - php71u-dbg
      - php71u-devel
      - php71u-fpm
      - php71u-intl
      - php71u-json
      - php71u-ldap
      - php71u-mbstring
      - php71u-mcrypt
      - php71u-mysqlnd
      - php71u-opcache
      - php71u-pdo
      - php71u-pecl-apcu
      - php71u-pecl-igbinary
      - php71u-pecl-imagick
      - php71u-pecl-memcached
      - php71u-xml
    - require:
      - pkgrepo: ius-release

{% for site in wiki %}
mediawiki_git_{{ site }}_install:
  git.latest:
    - name: https://gerrit.wikimedia.org/r/p/mediawiki/core.git
    - rev: {{ mediawiki.git_branch }}
    - branch: {{ mediawiki.git_branch }}
    - target: {{ mediawiki.install_dir }}/{{ site }}

# Vendor install required for Mediawiki
mediawiki_git_vendor_{{ site }}_install:
  git.latest:
    - name: https://gerrit.wikimedia.org/r/mediawiki/vendor.git
    - rev: {{ mediawiki.git_branch }}
    - branch: {{ mediawiki.git_branch }}
    - target: {{ mediawiki.install_dir }}/{{ site }}/vendor
{% endfor %}
