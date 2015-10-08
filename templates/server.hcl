#
# {{ ansible_managed }}
#
region = "{{ region }}"
datacenter = "{{ datacenter }}"
name = "{{ name }}"
data_dir = "/var/lib/nomad"
log_level = "DEBUG"
#bind_addr = "0.0.0.0"
enable_debug = false
ports {
  http = 4646
  rpc  = 4647
  serf = 4648
}
addresses {
  http = "0.0.0.0"
  #rpc  = "127.0.0.1"
  #serf = "127.0.0.1"
}
#advertise {
#  rpc  = "127.0.0.1"
#  serf = "127.0.0.1"
#}

# Enable the server
server {
  enabled = true

  # Self-elect, should be 3 or 5 for production
  bootstrap_expect = 3
}
