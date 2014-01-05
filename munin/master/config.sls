{% from "munin/map.jinja" import munin_master with context %}

include:
  - munin.master

munin_master_config:
  file.managed:
    - name: {{ munin_master.config }}
    - source: {{ munin_master.config_src }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644

