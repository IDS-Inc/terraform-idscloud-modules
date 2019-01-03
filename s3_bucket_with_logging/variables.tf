variable "bucket_name" {
  type = "string"
}

variable "version_retention_days" {
  type = "string"

  default = "365"
}

variable "log_retention_days" {
  type = "string"

  default = "365"
}
