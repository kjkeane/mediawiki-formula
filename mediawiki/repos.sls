ius-release:
  pkgrepo.managed:
    - humanname: IUS Community Packages for Enterprise Linux $releasever - $basearch
    - baseurl: https://dl.iuscommunity.org/pub/ius/stable/CentOS/$releasever/$basearch
    - gpgcheck: True
    - gpgkey: https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY
