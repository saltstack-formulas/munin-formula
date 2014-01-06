{% from "munin/map.jinja" import net_ssleay with context %}

net_ssleay:
  pkg.installed:
    - name: {{ net_ssleay.package }}
