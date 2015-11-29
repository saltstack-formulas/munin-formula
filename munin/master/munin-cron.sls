{% from "munin/map.jinja" import munin_master with context %}

include:
  - munin.master

{% if salt['grains.get']('os_family') == 'Arch' %}
cron_service:
  file.managed:
    - name: {{ munin_master.cron_service }}
    - source: salt://munin/files/Arch/munin-cron.service
    - user: root
    - group: root
    - mode: 644

cron_timer:
  file.managed:
    - name: {{ munin_master.cron_timer }}
    - source: salt://munin/files/Arch/munin-cron.timer
    - user: root
    - group: root
    - mode: 644

munin-cron.timer:
  service.running:
    - enable: True
    - watch:
      - file: cron_service
      - file: cron_timer

{% endif %}
