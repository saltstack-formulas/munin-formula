{% from "munin/map.jinja" import munin_master with context %}

munin_master:
  pkg.installed:
    - name: {{ munin_master.package }}
