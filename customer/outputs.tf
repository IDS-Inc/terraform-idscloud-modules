output "access_key_id" {
  value = "${aws_iam_access_key.customer_access_key.id}"
}

output "secret" {
  value = "${aws_iam_access_key.customer_access_key.secret}"
}

output "interfaces_bucket" {
  value = "${local.s3_interfaces_bucket}"
}
