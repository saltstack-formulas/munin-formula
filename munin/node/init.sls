{% from "munin/map.jinja" import munin_node with context %}

munin_node:
  pkg.installed:
    - name: {{ munin_node.package }}
  service.running:
    - enable: True
    - name: {{ munin_node.service }}
    - require:
      - pkg: {{ munin_node.package }}
