variable "enable_jump_box" {
  default = false
}

variable "key_name" {
  type = "string"
}

variable "subnets" {
  type = "list"
}

variable "name" {
  type    = "string"
  default = "Jump Box"
}
