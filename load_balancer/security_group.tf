resource "aws_security_group" "load_balancer" {
  vpc_id = "${var.vpc_id}"
  name   = "${var.name}_ALB"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Inbound SSL"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound traffic"
  }
}
