variable "public_subnets" {
  type = "list"
}

variable "name" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "ssl_policy" {
  type    = "string"
  default = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "default_ssl_acm_arn" {
  type = "string"
}
