module "web_cluster" {
  for_each = var.servers
  source   = "./module/web-node"

  node_name     = "${local.name_prefix}-${each.key}"
  instance_type = each.value.instance_type
  allowed_ports = each.value.allowed_ports
  ami_id        = data.aws_ami.ubuntu.id
  tags          = local.common_tags
}

