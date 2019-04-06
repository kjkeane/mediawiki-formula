# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mediawiki with context %}

mediawiki-packages-pkg-installed:
  pkg.installed:
    - pkgs:
{%- for pkg in mediawiki.pkgs %}
      - {{ pkg }}
{%- endfor %}
{%- if grains['os_family'] == 'RedHat' %}
    - require:
      - pkgrepo: ius-release-repo
{%- endif %}

{% for site in mediawiki.sites %}
mediawiki-git-{{ site }}-install:
  git.latest:
    - name: https://gerrit.wikimedia.org/r/p/mediawiki/core.git
    - rev: {{ mediawiki.git_branch }}
    - branch: {{ mediawiki.git_branch }}
    - target: {{ mediawiki.install_dir }}/{{ site }}
    - require:
      - pkg: mediawiki-packages-pkg-installed

# Vendor install required for Mediawiki
mediawiki-git_vendor-{{ site }}-install:
  git.latest:
    - name: https://gerrit.wikimedia.org/r/mediawiki/vendor.git
    - rev: {{ mediawiki.git_branch }}
    - branch: {{ mediawiki.git_branch }}
    - target: {{ mediawiki.install_dir }}/{{ site }}/vendor
    - require:
      - git: mediawiki-git-{{ site }}-install
{% endfor %}
