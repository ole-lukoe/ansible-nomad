#
# {{ ansible_managed }}
# ansible_default_ipv4: {{ ansible_default_ipv4 }}
# ansible_hostname: {{ ansible_hostname }}
# ansible_nodename: {{ ansible_nodename }}
#
region = "{{ nomad_region }}"
datacenter = "{{ nomad_datacenter }}"
name = "{{ ansible_nodename}}_{{ nomad_name }}"
data_dir = "/var/lib/nomad"
log_level = "DEBUG"
bind_addr = "{{ nomad_bind_addr }}"
enable_debug = false

ports {
  http = {{ nomad_port_http }}
  rpc  = {{ nomad_port_rpc }}
  serf = {{ nomad_port_serf }}
}
#addresses {
#  http = "{{ nomad_local_ipaddress }}"  ##
#  rpc  = "{{ nomad_local_ipaddress }}"  ## default value is bind_addr
#  serf = "{{ nomad_local_ipaddress }}"  ##
#}
advertise {
  rpc  = "{{ nomad_private_ipaddress }}:{{ nomad_port_rpc }}"
  serf = "{{ nomad_private_ipaddress }}:{{ nomad_port_serf }}"
}

{% if nomad_server_enabled %}
server {
  enabled = true
  # Self-elect, should be 3 or 5 for production
  bootstrap_expect = {{ nomad_bootstrap_expect }}
}
client {
  enabled = true
  servers = ["127.0.0.1:4647"]
}
{% else %}
client {
  enabled = true
  servers = [
  {% for s in servers %}
  "{{ s }}",
  {% endfor %}
  ]
}
{% endif %}
