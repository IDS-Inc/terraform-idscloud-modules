resource "aws_kms_key" "main" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = "${var.deletion_window_in_days}"
}

# Logs
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

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.main.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Bucket
resource "aws_s3_bucket" "main" {
  bucket        = "${var.bucket_name}"
  acl           = "private"
  force_destroy = true

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

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.main.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  depends_on = ["aws_s3_bucket.main_logs"]
}
