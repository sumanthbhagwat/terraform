output "deployed_servers" {
  description = "Summary map of all deployed servers and their security groups"
  value = {
    for server_key, mod in module.web_cluster :
    server_key => {
      instance_id       = mod.instance_id
      public_ip         = mod.public_ip
      security_group_id = mod.security_group_id
    }
  }
}

