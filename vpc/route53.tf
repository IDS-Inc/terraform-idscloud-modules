resource "aws_route53_zone" "main" {
  name   = "${var.service_dns_zone_name}"
  vpc_id = "${aws_vpc.main.id}"
}

#resource "aws_service_discovery_private_dns_namespace" "main" {
#  name   = "${var.service_dns_zone_name}"
#  vpc_id = "${aws_vpc.main.id}"
#}

