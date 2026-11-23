variable "aws_region"{
  type=string
  description="region to which resources deployed"
}

variable"project_name"{
  type=string
  description="name of the project"
  default="web-app"

}

variable"instance_type"{
  description="ec2 instance size"
  type=string
}

variable"env"{
  type=string
  description="environment of project"
  validation{
    condition=contains(["dev","prod","staging"],var.env)
    error_message="dev,prod,staging env's only are allowed"
  }
}

variable"allowed_ports"{
  type=list(number)
  description="ports allowed for security group"
}

variable "servers" {
  description = "Map of servers to deploy using the web-node child module"
  type = map(object({
    instance_type = optional(string, "t3.micro")
    allowed_ports = optional(list(number), [22, 80])
  }))
}
