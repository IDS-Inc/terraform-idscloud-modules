variable "name" {
  type = "string"
}

variable "backup_retention_period" {
  type    = "string"
  default = "7"
}

# See the following link for information about the next two variables
# Engine and EnvineVersion
# https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html

variable "engine" {
  type    = "string"
  default = "sqlserver-se"
}

variable "engine_version" {
  type    = "string"
  default = "13.00.4466.4.v1"
}

variable "engine_version_major" {
  type    = "string"
  default = "13.00"
}

variable "instance_class" {
  type    = "string"
  default = "db.m4.large"
}

variable "monitoring_interval" {
  type    = "string"
  default = "1"
}

variable "monitoring_role_arn" {
  type    = "string"
}

variable "multi_az" {
  type    = "string"
  default = "true"
}

variable "password" {
  type    = "string"
  default = "password"
}

variable "restore_snapshot" {
  type    = "string"
}

variable "security_groups" {
  type    = "list"
  default = []
}

variable "skip_final_snapshot" {
  type    = "string"
  default = "false"
}

variable "snapshot_identifier" {
  type    = "string"
}

variable "storage" {
  type = "string"
}

variable "subnets" {
  type = "list"
}

variable "timezone" {
  type    = "string"
  default = "UTC"
}

variable "username" {
  type    = "string"
  default = "administrator"
}
