# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mediawiki with context %}


{%- for site, site_items in mediawiki.sites.items() %}
mediawiki-{{ site }}-vector-skin-install:
  git.latest:
    - name: https://gerrit.wikimedia.org/r/mediawiki/skins/Vector.git
    - rev: {{ mediawiki.git_branch }}
    - branch: {{ mediawiki.git_branch }}
    - target: {{ mediawiki.install_dir }}/{{ site }}/skins/Vector
    - require:
      - sls: {{ sls_package_install }}
{%- if site_items.skins is defined %}
{%- for skin in site_items.skins %}
mediawiki-{{ site }}-{{ skin }}-install:
  git.latest:
    - name: https://gerrit.wikimedia.org/r/mediawiki/skins/{{ skin }}.git
    - rev: {{ mediawiki.git_branch }}
    - branch: {{ mediawiki.git_branch }}
    - target: {{ mediawiki.install_dir }}/{{ site }}/skins/{{ skin }}
    - require:
      - sls: {{ sls_package_install }}
{%- endfor %}
{%- endif %}
{%- endfor %}
