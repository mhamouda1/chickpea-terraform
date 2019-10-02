variable "AWS_REGION" {}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

variable "project_name" {}

variable "public_subnets_1" {
  type = "list"
}

variable "public_subnets_2" {
  type = "list"
}

variable "private_subnets_1" {
  type = "list"
}

variable "num_workers" {}
