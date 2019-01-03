output "http_listener_arn" {
  value      = "${coalesce(aws_lb_listener.http.arn, "")}"
  depends_on = ["aws_lb_listener.http"]
}

output "https_listener_arn" {
  value      = "${coalesce(aws_lb_listener.https.arn, "")}"
  depends_on = ["aws_lb_listener.https"]
}

output "security_group_id" {
  value = "${aws_security_group.load_balancer.id}"
}
