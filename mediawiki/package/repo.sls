{%- if grains['os_family'] == 'RedHat' -%}
ius-release-repo:
  pkgrepo.managed:
    - name: ius-release
    - humanname: IUS Community Packages for Enterprise Linux $releasever - $basearch
    - baseurl: https://dl.iuscommunity.org/pub/ius/stable/CentOS/$releasever/$basearch
    - gpgcheck: True
    - gpgkey: https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY
{%- endif -%}
