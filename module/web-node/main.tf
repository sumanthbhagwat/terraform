resource "aws_security_group" "node_sg" {
  name_prefix = "${var.node_name}-sg-"
  description = "Dynamic firewall rules for ${var.node_name}"

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow TCP port ${ingress.value}"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.node_name}-sg"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "node" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.node_sg.id]

  tags = merge(var.tags, {
    Name = var.node_name
  })
}
