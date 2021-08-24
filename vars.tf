variable "vpc_id" {
  type = string
}

variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
  description = "Map of tags to assign to all possible inner resources."
  default = {}
}

variable "allow_self_ingress" {
  type = bool
  default = false
}

variable "ingress_cidr_blocks" {
  type = map(object({
    cidr_blocks = list(string)
    protocol = string
    port = number
  }))
  default = {}
}

variable "ingress_security_groups" {
  type = map(object({
    security_group_id = string
    protocol = string
    port = number
  }))
  default = {}
}
