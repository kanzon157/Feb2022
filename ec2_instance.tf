resource "aws_vpc" "myvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    "Name" = "myvpc"
  }
}

locals {
  ingress_rules = [
    {
      port        = 80
      description = "Allow SSH"
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    },
    {
      port        = 22
      description = "Allow HTTP"
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    },
    {
      port        = 443
      description = "Allow HTTPS"
      cidr_blocks = ["0.0.0.0/0"]
      protocol    = "tcp"
    },
  ]
}
resource "aws_security_group" "web_sg" {
  name   = "web_sg"
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      to_port     = ingress.value.port
      from_port   = ingress.value.port
      protocol    = ingress.value.protocol
    }
  }

}