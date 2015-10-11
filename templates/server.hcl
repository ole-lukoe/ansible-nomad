#
# {{ ansible_managed }}
# ansible_default_ipv4: {{ ansible_default_ipv4 }}
# ansible_hostname: {{ ansible_hostname }}
# ansible_nodename: {{ ansible_nodename }}
#
region = "{{ region }}"
datacenter = "{{ datacenter }}"
name = "{{ ansible_nodename}}_{{ name }}"
data_dir = "/var/lib/nomad"
log_level = "DEBUG"
bind_addr = "{{ bind_addr }}"
enable_debug = false

ports {
  http = {{ port_http }}
  rpc  = {{ port_rpc }}
  serf = {{ port_serf }}
}
#addresses {
#  http = "{{ local_ipaddress }}"  ##
#  rpc  = "{{ local_ipaddress }}"  ## default value is bind_addr
#  serf = "{{ local_ipaddress }}"  ##
#}
advertise {
  rpc  = "{{ private_ipaddress }}:{{ port_rpc }}"
  serf = "{{ private_ipaddress }}:{{ port_serf }}"
}

{% if server_enabled %}
server {
  enabled = true
  # Self-elect, should be 3 or 5 for production
  bootstrap_expect = 3
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
