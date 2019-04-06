# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mediawiki with context %}
{%- from tplroot ~ "/macros.jinja" import files_switch with context %}

{% for site, site_items in mediawiki.sites.items() %}
mediawiki-{{ site }}-config:
  file.managed:
    - name: {{ mediawiki.install_dir }}/{{ site }}/LocalSettings.php
    - source: {{ files_switch(
                    salt['config.get'](
                        tplroot ~ ':tofs:files:mediawiki-config',
                        ['LocalSettings.tmpl.jinja', 'LocalSettings.tmpl']
                    )
              ) }}
    - template: jinja
    - context:
        mediawiki: {{ mediawiki|json }}
        site: {{ site }}
        site_items: {{ site_items|json }}
    - user: {{ mediawiki.user }}
    - group: {{ mediawiki.group }}
    - mode: 644
    - require:
      - sls: {{ sls_package_install }}
{%- endfor %}
