resource "aws_lb" "main" {
  name               = "${var.name}"
  subnets            = ["${var.public_subnets}"]
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.load_balancer.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = "${aws_lb.main.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.empty.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = "${aws_lb.main.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "${var.ssl_policy}"
  certificate_arn   = "${var.default_ssl_acm_arn}"

  default_action {
    target_group_arn = "${aws_lb_target_group.empty.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "empty" {
  name        = "${replace(var.name, "/[ _]/", "-")}-catch-all"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"
  target_type = "instance"

  lifecycle {
    create_before_destroy = true
  }
}
