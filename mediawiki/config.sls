{% from "mediawiki/map.jinja" import mediawiki with context %}
{% set wiki = salt['pillar.get']('mediawiki', {}) %}

{% for site, site_items in wiki.items() %}
mediawiki_{{ site }}_config:
  file.managed:
    - name: {{ mediawiki.install_dir }}/{{ site }}/LocalSettings.php
    - source: {{ mediawiki.config_file_source }}
    - template: jinja
    - context:
        site: {{ site }}
        site_items: {{ site_items|json }}
    - user: {{ mediawiki.user }}
    - group: {{ mediawiki.group }}
    - mode: 644
{% endfor %}
