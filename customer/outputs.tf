# Customer
output "customer_bucket" {
  value = "${local.s3_interfaces_bucket}"
}

output "customer_access_key_id" {
  value = "${aws_iam_access_key.customer_access_key.id}"
}

output "customer_secret" {
  value = "${aws_iam_access_key.customer_access_key.secret}"
}

# Origination
output "origination_bucket" {
  value = "${local.s3_origination_bucket}"
}

output "origination_access_key_id" {
  value = "${aws_iam_access_key.origination_access_key.id}"
}

output "origination_secret" {
  value = "${aws_iam_access_key.origination_access_key.secret}"
}

# Insurance
output "insurance_bucket" {
  value = "${local.s3_insurance_bucket}"
}

output "insurance_access_key_id" {
  value = "${aws_iam_access_key.insurance_access_key.id}"
}

output "insurance_secret" {
  value = "${aws_iam_access_key.insurance_access_key.secret}"
}

# Bank
output "bank_bucket" {
  value = "${local.s3_bank_bucket}"
}

output "bank_access_key_id" {
  value = "${aws_iam_access_key.bank_access_key.id}"
}

output "bank_secret" {
  value = "${aws_iam_access_key.bank_access_key.secret}"
}
