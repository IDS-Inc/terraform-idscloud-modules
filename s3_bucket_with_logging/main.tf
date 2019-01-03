# TODO: change "configuration_files" and "configuration_files_logs" to "main"

# Configuration logs
resource "aws_s3_bucket" "configuration_files_logs" {
  bucket        = "${var.bucket_name}.logs"
  acl           = "log-delivery-write"
  force_destroy = true

  lifecycle_rule {
    id                                     = "Remove versions after ${var.log_retention_days} days"
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

# Configurations
resource "aws_s3_bucket" "configuration_files" {
  bucket = "${var.bucket_name}"
  acl    = "private"

  logging {
    target_bucket = "${aws_s3_bucket.configuration_files_logs.id}"
    target_prefix = "${var.bucket_name}-s3/"
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id                                     = "Remove versions after ${var.version_retention_days} days"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    noncurrent_version_expiration {
      days = "${var.version_retention_days}"
    }

    expiration {
      expired_object_delete_marker = true
    }
  }

  depends_on = ["aws_s3_bucket.configuration_files"]
}
