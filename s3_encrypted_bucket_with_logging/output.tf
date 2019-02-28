output "s3_encrypted_bucket_with_logging_kms_key_arn" {
  value = "${aws_kms_key.main.arn}"
}
