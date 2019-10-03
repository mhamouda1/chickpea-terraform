variable "AWS_SECRET_ACCESS_KEY" {}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_REGION" {}

variable "database" {
  type = "map"
}

variable "project_name" {}
variable "num_workers" {}
variable "num_cache_nodes" {}
variable "target_group_port" {}

variable "public_subnets_1" {
  type = "list"
}

variable "public_subnets_2" {
  type = "list"
}

variable "private_subnets_1" {
  type = "list"
}
