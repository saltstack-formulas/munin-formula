{% from "munin/map.jinja" import munin_node with context %}

include:
  - munin.node

# Enable common plugins
{% for plugin, linked_file in pillar.get('munin_node_common_plugins', {}).items() %}
/etc/munin/plugins/{{ plugin }}:
  file.symlink:
    - target: {{ munin_node.plugin_dir}}/{{ linked_file }}
    - user: root
    - group: root
    - mode: 755
{% endfor %}

# Node specific plugins
{% for hostname, plugin in salt['pillar.get']('munin_node_specific_plugins').items() %}
{% if salt['pillar.get']('munin_node:host_name') == hostname %}
{% for plugin_name, linked_file in plugin.items() %}
/etc/munin/plugins/{{ plugin_name }}:
  file.symlink:
    - target: {{ munin_node.plugin_dir}}/{{ linked_file }}
    - user: root
    - group: root
    - mode: 755
{% endfor %}
{% endif %}
{% endfor %}

{{ munin_node.service }}:
  service.running:
    - watch:
      - file: /etc/munin/plugins/*
