{% from "munin/map.jinja" import munin_node with context %}

include:
  - munin.node

munin_node_config:
  file.managed:
    - name: {{ munin_node.config }}
    - source: {{ munin_node.config_src }}
    - template: jinja
    - watch_in:
      - service: munin_node
