variable "node_name" {
  type        = string
  description = "Name for the EC2 instance and its security group"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance size"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to launch"
}

variable "allowed_ports" {
  type        = list(number)
  
  description = "List of TCP ports to open"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Common tags to apply"
}
