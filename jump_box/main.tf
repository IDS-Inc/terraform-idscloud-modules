resource "aws_security_group" "main" {
  vpc_id = "${data.aws_subnet.main.vpc_id}"
  name   = "${var.name}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound traffic"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "jump_box" {
  ami                    = "${data.aws_ami.ec2-linux.image_id}"
  count                  = "${var.enable_jump_box}"
  instance_type          = "t2.small"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.main.id}"]
  subnet_id              = "${data.aws_subnet.main.id}"

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  user_data = <<-EOF
                                #!/bin/bash
                                yum -y update
                                EOF

  tags = {
    Name = "${var.name}"
  }
}
