{% from "mediawiki/map.jinja" import mediawiki with context %}
{% set wiki = salt['pillar.get']('mediawiki', {}) %}

{% for site, site_items in wiki.items() %}
{% for plugin, plugin_items in site_items.plugins.items() %}
{{ plugin }}_{{ site }}_install:
  git.latest:
    - name: https://gerrit.wikimedia.org/r/mediawiki/extensions/{{ plugin }}.git
    - rev: {{ mediawiki.git_branch }}
    - branch: {{ mediawiki.git_branch }}
    - target: {{ mediawiki.install_dir }}/{{ site }}/extensions/{{ plugin }}
{% endfor %}
{% endfor %}
