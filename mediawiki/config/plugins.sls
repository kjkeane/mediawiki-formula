# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mediawiki with context %}
{%- from tplroot ~ "/macros.jinja" import files_switch with context %}

{%- for site, site_items in mediawiki.items() %}
{%- if plugins is defined %}
{%- for plugin, plugin_items in site_items.plugins.items() %}
{{ site }}-{{ plugin }}-install:
  git.latest:
    - name: https://gerrit.wikimedia.org/r/mediawiki/extensions/{{ plugin }}.git
    - rev: {{ mediawiki.git_branch }}
    - branch: {{ mediawiki.git_branch }}
    - target: {{ mediawiki.install_dir }}/{{ site }}/extensions/{{ plugin }}
    - require:
      - sls: {{ sls_package_install }}
{%- endfor %}
{%- endif %}
{%- endfor %}
