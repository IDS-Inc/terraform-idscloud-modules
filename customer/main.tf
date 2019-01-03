resource "random_string" "rand_hostname" {
  length  = 8
  special = false
  upper   = false
}

locals {
  s3_interfaces_bucket = "${var.customer_name}-interfaces-${random_string.rand_hostname.result}.idscloud"
}
