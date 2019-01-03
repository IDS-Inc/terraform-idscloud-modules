module "customer_s3_bucket" {
  source                 = "../s3_encrypted_bucket_with_logging"
  bucket_name            = "${local.s3_interfaces_bucket}"
  version_retention_days = "365"
  log_retention_days     = "365"                                 # 1 year
}

resource "aws_s3_bucket_object" "upload_default_object" {
  key                    = "upload/readme.txt"
  bucket                 = "${local.s3_interfaces_bucket}"
  content                = "Files uploaded into this directory structure will be processed by the system."
  server_side_encryption = "aws:kms"
  depends_on             = ["module.customer_s3_bucket"]
}

resource "aws_s3_bucket_object" "download_default_object" {
  key                    = "download/readme.txt"
  bucket                 = "${local.s3_interfaces_bucket}"
  content                = "Files created by the system are placed into this directory structure for download."
  server_side_encryption = "aws:kms"
  depends_on             = ["module.customer_s3_bucket"]
}
