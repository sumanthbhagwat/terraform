aws_region="us-east-1"
allowed_ports=["22","80","443"]
instance_type="t3.micro"
env="dev"

servers = {
  frontend = {
    instance_type = "t3.micro"
    allowed_ports = [22, 80, 443]
  }
  backend-api = {
    instance_type = "t3.micro"
    allowed_ports = [22, 8080]
  }
}