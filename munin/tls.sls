{% from "munin/map.jinja" import net_ssleay, munin_tls with context %}

net_ssleay:
  pkg.installed:
    - name: {{ net_ssleay.package }}

{%- if salt['pillar.get']('munin_tls:private_pem') %}
munin_tls_private_key:
  file.managed:
    - name: {{ munin_tls.private_key }}
    - user: munin
    - group: munin
    - mode: 600
    - contents_pillar: munin_tls:private_pem
    - makedirs: True
    - dir_mode: 700
{%- endif %}

{%- if salt['pillar.get']('munin_tls:certificate_pem') %}
munin_tls_certificate:
  file.managed:
    - name: {{ munin_tls.certificate }}
    - user: munin
    - group: munin
    - mode: 600
    - contents_pillar: munin_tls:certificate_pem
    - makedirs: True
    - dir_mode: 700
{%- endif %}

{%- if salt['pillar.get']('munin_tls:ca_certificate_pem') %}
munin_tls_ca_certificate:
  file.managed:
    - name: {{ munin_tls.ca_certificate }}
    - user: munin
    - group: munin
    - mode: 600
    - contents_pillar: munin_tls:ca_certificate_pem
    - makedirs: True
    - dir_mode: 700
{%- endif %}
