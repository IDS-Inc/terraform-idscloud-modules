# Configuration logs
resource "aws_s3_bucket" "main_logs" {
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

  tags = {
  }

}

# Configurations
resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}"
  acl    = "private"

  logging {
    target_bucket = "${aws_s3_bucket.main_logs.id}"
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

  tags = {
  }
  
  depends_on = ["aws_s3_bucket.main"]
}
