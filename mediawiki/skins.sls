{% from "mediawiki/map.jinja" import mediawiki with context %}
{% set wiki = salt['pillar.get']('mediawiki', {}) %}

{% for site, site_items in wiki.items() %}
{% for skin, skin_items in site_items.skins.items() %}
{{ site }}_{{ skin }}_install:
  git.latest:
    - name: https://gerrit.wikimedia.org/r/mediawiki/skins/{{ skin }}.git
    - rev: {{ mediawiki.git_branch }}
    - target: {{ mediawiki.install_dir }}/{{ site }}/skins/{{ skin }}
{% endfor %}
{% endfor %}
