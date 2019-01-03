variable "name" {
  type = "string"
}

variable "instance_class" {
  type    = "string"
  default = "db.m4.large"
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

variable "storage" {
  type = "string"
}

variable "subnets" {
  type = "list"
}

variable "username" {
  type    = "string"
  default = "administrator"
}

variable "password" {
  type    = "string"
  default = "password"
}

variable "multi_az" {
  type    = "string"
  default = "true"
}

variable "backup_retention_period" {
  type    = "string"
  default = "7"
}

variable "security_groups" {
  type    = "list"
  default = []
}

variable "timezone" {
  type    = "string"
  default = "UTC"
}
