resource "aws_s3_bucket" "main" {
  bucket        = "${var.bucket_name}"
  policy        = "${data.aws_iam_policy_document.s3_cloudtrail.json}"
  force_destroy = true

  lifecycle_rule {
    id                                     = "Remove logs after ${var.log_retention_days} days"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    noncurrent_version_expiration {
      days = "${var.log_retention_days}"
    }

    expiration {
      expired_object_delete_marker = true
    }
  }
}

resource "aws_cloudtrail" "main" {
  name                       = "${var.name}"
  s3_bucket_name             = "${aws_s3_bucket.main.id}"
  is_multi_region_trail      = true
  enable_log_file_validation = true
}
